import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';

// Models
import '../models/gas_limit.dart';
import '../models/gas_station.dart';
import '../models/gas_ticket.dart';

// Services
import '../services/gas_service.dart';

class GasController extends GetxController {
  final authController = Get.find<AuthController>();
  final locationController = Get.find<LocationController>();
  var gasLimit = <GasLimit>{}.obs;
  var gasTicketList = <GasTicket>[].obs;
  var gasTicketHistoryList = <GasTicket>[].obs;
  var gasStationList = <GasStation>[].obs;
  var isLoadingSendRequest = false.obs;

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'formKey');
  // final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>(debugLabel: 'updateFormKey');
  var formKeys =
      List.generate(2, (index) => GlobalObjectKey<FormState>(index)).obs;
  var note = ''.obs;
  final noteController = TextEditingController();
  var limit = 100.obs;

  // update Form
  var actualLit = 0.0.obs;
  var unitPrice = 0.obs;
  var odoCurrent = 0.obs;
  var imagePickerList = <XFile?>[].obs;
  final ImagePicker imagePicker = ImagePicker();

  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    fetchGasLimit();
    super.onInit();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> fetchGasLimit() async {
    try {
      var result =
          await GasService.fetchGasLimit(authController.auth.single.driverId);

      if (result != null) {
        gasLimit.assign(result);
      } else {
        debugPrint('No data');
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  String convertReqStatusToText(int reqStatus, int checkExists) {
    if (reqStatus == 0 && checkExists == 0) {
      return 'Hiện tại không có phiếu. Hãy "Gửi yêu cầu" mới';
    } else if (reqStatus == 1 && checkExists == 1) {
      return 'Phiếu chưa hoàn tất. Hãy bấm "Xem yêu cầu"';
    } else if (reqStatus == 2) {
      return 'Phiếu yêu cầu đã bị từ chối. Hãy "Gửi yêu cầu" mới';
    } else {
      return '';
    }
  }

  Future<void> sendRequestGas(BuildContext context) async {
    try {
      if (gasLimit.isNotEmpty) {
        if (gasLimit.single.reqStatus == 1 &&
            gasLimit.single.checkExists == 1) {
          TextContent.getXSnackBar(
              '', 'Phiếu chưa hoàn tất. Hãy bấm "Xem yêu cầu"', true);
          return;
        }
      }

      if (!formKeys[0].currentState!.validate()) {
        return;
      } else {
        // close keyboard
        FocusScope.of(context).unfocus();
        // waiting
        isLoadingSendRequest(true);

        var result = await GasService.sendRequestGas(
          authController.auth.single.fullName,
          authController.auth.single.driverId,
          gasLimit.single.powerUnit ?? '',
          note.value,
        );

        if (result == 1) {
          fetchGasLimit();
          noteController.text = '';
          imagePickerList.assignAll([]);
          fetchGasTicket().then((_) {
            fetchGasStation().then((_) {
              Get.toNamed(AppRoutes.gasCurrentRequestLink);
              TextContent.getXSnackBar('', 'Gửi yêu cầu thành công!', true);
            });
          });
        } else {
          TextContent.getXSnackBar('', 'Gửi yêu cầu thất bại!', true);
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingSendRequest(false);
    }
  }

  Future<void> fetchGasTicket() async {
    try {
      // if (gasLimit.single.reqStatus == 0 && gasLimit.single.checkExists == 0) {
      //   return;
      // }

      var result =
          await GasService.fetchGasTicket(authController.auth.single.driverId);

      if (result != null) {
        gasTicketList.assignAll([]);
        gasTicketList.assignAll(result);
        imagePickerList.assignAll([]);
        fetchGasStation();
        Get.toNamed(AppRoutes.gasCurrentRequestLink);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchGasStation() async {
    try {
      var result =
          await GasService.fetchGasStation(authController.auth.single.driverId);

      if (result != null) {
        gasStationList.assignAll([]);
        gasStationList.assignAll(result);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  void setGasStationName(int index) {
    locationController.getCurrentLocation();

    var lat1 = locationController.currentLat.value;
    var lon1 = locationController.currentLng.value;
    var lat2 = gasStationList[index].lat;
    var lon2 = gasStationList[index].lng;

    // debugPrint('Current Lat, Lng: $lat1 - $lon1');
    // debugPrint('Gas Station Lat, Lng: $lat2 - $lon2');

    var distanceMeters = calculateDistanceMeters(lat1, lon1, lat2, lon2);

    if (gasStationList[index]
        .gasStationName
        .toString()
        .contains('Không Xác định')) {
      gasTicketList[0].gasStationName = gasStationList[index].gasStationName;
      gasTicketList.refresh();
    } else {
      if (distanceMeters > 200.0) {
        Get.defaultDialog(
          title: 'Thông báo',
          content:
              const Text('Chọn sai cây dầu, vui lòng chọn cây dầu gần bạn nhất.'),
        );

        Future.delayed(const Duration(milliseconds: 2000), () => Get.back());

        return;
      } else {
        gasTicketList[0].gasStationName = gasStationList[index].gasStationName;
        gasTicketList.refresh();
      }
    }
  }

  void takeImage(int key) async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (key == 1) {
      if (image != null) {
        if (imagePickerList.isEmpty) {
          imagePickerList.insert(0, image);
        } else {
          imagePickerList.removeAt(0);
          imagePickerList.insert(0, image);
        }
        uploadImage(imagePickerList[0], 'Image Odo Current');
      }
    } else {
      if (image != null) {
        if (imagePickerList.length == 1) {
          imagePickerList.insert(1, image);
        } else if (imagePickerList.length > 1) {
          imagePickerList.removeAt(1);
          imagePickerList.insert(1, image);
        }
        uploadImage(imagePickerList[1], 'Image Actual Qty');
      }
    }
  }

  void takeImageGallery(int key) async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (key == 1) {
      if (image != null) {
        if (imagePickerList.isEmpty) {
          imagePickerList.insert(0, image);
        } else {
          imagePickerList.removeAt(0);
          imagePickerList.insert(0, image);
        }
        uploadImage(imagePickerList[0], 'Image Odo Current');
      }
    } else {
      if (image != null) {
        if (imagePickerList.length == 1) {
          imagePickerList.insert(1, image);
        } else if (imagePickerList.length > 1) {
          imagePickerList.removeAt(1);
          imagePickerList.insert(1, image);
        }
        uploadImage(imagePickerList[1], 'Image Actual Qty');
      }
    }
  }

  void openDialogTakePicture(int key) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          TextButton(
            onPressed: () {
              takeImageGallery(key);
            },
            child: const Text('Chọn ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              takeImage(key);
            },
            child: const Text('Chụp hình'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(TextContent.btnClose),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage(XFile? image, String type) async {
    try {
      var result = await GasService.uploadImage(
          'Bearer ${authController.auth.single.accessToken}',
          image!,
          0,
          gasTicketList[0].ticketId ?? '',
          type);

      if (result == 1) {
        TextContent.getXSnackBar('', 'Gửi hình thành công!', true);
      } else {
        TextContent.getXSnackBar('', 'Gửi hình thất bại', true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  int? getStationId(String gasStationName) {
    if (gasStationList.isNotEmpty) {
      return gasStationList
          .where((p0) => p0.gasStationName == gasStationName)
          .single
          .gasStationId;
    }
    return null;
  }

  Future<void> updateGasRequest(BuildContext context) async {
    try {
      if (gasTicketList.isNotEmpty) {
        // debugPrint(gasTicketList[0].gasStationName ?? '');
        String gasStationName = gasTicketList[0].gasStationName ?? '';
        if (gasStationName == '') {
          TextContent.getXSnackBar('', 'Vui lòng chọn cây dầu.', true);
          return;
        }
      }

      if (!formKeys[1].currentState!.validate()) {
        return;
      }

      if (imagePickerList.length < 2) {
        TextContent.getXSnackBar('', 'Vui lòng chụp đủ 2 hình', true);
        return;
      }

      // close keyboard
      FocusScope.of(context).unfocus();
      formKeys[1].currentState!.save();

      var result = await GasService.updateGasRequest(
        gasTicketList[0].ticketId ?? '',
        getStationId(gasTicketList[0].gasStationName ?? '') ?? 0,
        0.0,
        0.0,
        odoCurrent.value,
        double.parse(actualLit.value.toString()),
        double.parse(unitPrice.value.toString()),
        authController.auth.single.fullName,
        double.parse(actualLit.value.toString()) *
            double.parse(unitPrice.value.toString()),
      );

      if (result == 1) {
        fetchGasLimit().then((_) => Get.offNamed(AppRoutes.gasLink));
        TextContent.getXSnackBar('', 'Cập nhật phiếu dầu thành công.', true);
        unitPrice.value = 0;
        actualLit.value = 0.0;
      } else {
        TextContent.getXSnackBar('', 'Cập nhật phiếu dầu thất bại.', true);
        unitPrice.value = 0;
        actualLit.value = 0.0;
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  void openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      locale: const Locale('vi', 'VN'),
      initialDate: selectedDate.value,
      firstDate: DateTime(2019),
      lastDate: DateTime(9999),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        selectedDate.value = pickedDate;
        fetchGasTicketHistory();
      }
    });
  }

  Future<void> fetchGasTicketHistory() async {
    try {
      var result = await GasService.fetchGasTicketHistory(
          DateFormat('yyyy-MM-dd').format(selectedDate.value),
          authController.auth.single.driverId);

      if (result != null) {
        gasTicketHistoryList.assignAll(result);
      } else {
        gasTicketHistoryList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  String getLit100Km(int index) {
    if (gasTicketHistoryList.isNotEmpty) {
      var actualQty = gasTicketHistoryList[index].actualQty ?? 0;
      var odoPrevious = gasTicketHistoryList[index].odoPrevious ?? 0;
      var odoCurrent = gasTicketHistoryList[index].odoCurrent ?? 0;
      return ((actualQty / (odoCurrent - odoPrevious)) * 100)
          .toStringAsFixed(1);
    } else {
      return '0';
    }
  }

  double calculateDistanceMeters(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 1000 * 12742 * asin(sqrt(a));
  }
}
