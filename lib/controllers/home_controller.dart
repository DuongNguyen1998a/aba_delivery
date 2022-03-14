import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// Constants
import '../constants/app_routes.dart';
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';

//Models
import '../models/shipment.dart';
import '../models/shipment_complete.dart';
import '../models/shipment_stop.dart';

// Services
import '../services/giao_chi_tiet_service.dart';
import '../services/home_service.dart';

class HomeController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final locationController = Get.find<LocationController>();
  var isLoading = false.obs;
  var isLoadingDaToi = false.obs;
  var isLoadingPickupDepot = false.obs;
  var currentShipment = <Shipment>[].obs;
  var currentShipmentStops = <ShipmentStop>[].obs;

  // form người nhận
  final GlobalKey<FormState> formKey = GlobalKey();
  var tenNguoiNhan = ''.obs;
  var sdtNguoiNhan = ''.obs;
  var isLoadingNguoiNhan = false.obs;

  // Chụp hình giao hàng
  var totalCarton = 0.obs;

  var cbThieu = false.obs;
  var valueCbThieu = 0.obs;
  var cbDu = false.obs;
  var valueCbDu = 0.obs;
  var cbHong = false.obs;
  var valueCbHong = 0.obs;
  var cbKem = false.obs;
  var valueCbKem = 0.obs;

  // Sai lech hang
  var listImage = <XFile>[].obs;
  final noteController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  var isLoadingSaiHang = false.obs;

  /// Hoàn thành chuyến
  var listImageCompleteShipment = <XFile>[].obs;
  var shipmentCompletedList = <ShipmentComplete>[].obs;
  var isLoadingADCADBiker = false.obs;
  var isLoadingADCAD = false.obs;

  void openDialogCamera1() {
    Get.defaultDialog(
      title: '',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              pickImage();
              Get.back();
            },
            child: const Text('Chọn ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              takeImage1();
              Get.back();
            },
            child: const Text('Chụp hình'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void takeImage1() async {
    final XFile? mTakeImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakeImage != null) {
      listImageCompleteShipment.add(mTakeImage);
    }
  }

  void pickImage() async {
    final XFile? mTakeImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakeImage != null) {
      listImageCompleteShipment.add(mTakeImage);
    }
  }

  /// Hoàn thành chuyến

  void takeImage() async {
    final XFile? mTakeImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakeImage != null) {
      listImage.add(mTakeImage);
    }
  }

  void openDialogCamera() {
    Get.defaultDialog(
      title: '',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              takeImage();
              Get.back();
            },
            child: const Text('Chụp hình'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  // Sai lech hang

  void setDefaultValue() {
    cbThieu.value = false;
    valueCbThieu.value = 0;
    cbDu.value = false;
    valueCbDu.value = 0;
    cbHong.value = false;
    valueCbHong.value = 0;
    cbKem.value = false;
    valueCbKem.value = 0;
  }

  @override
  void onInit() {
    Get.put(() => LocationController());

    fetchCurrentShipments().then((_) {
      if (currentShipment.isNotEmpty) {
        if (authController.auth.single.isBiker == 'True') {
          currentShipment[0].denKho ? fetchShipmentStops() : null;
          update();
        } else {
          currentShipment[0].donePickup ? fetchShipmentStops() : null;
          update();
        }
      }
    });

    super.onInit();
  }

  Future<void> refreshData() async {
    currentShipment.value = [];
    currentShipmentStops.value = [];
    await fetchCurrentShipments().then((_) {
      if (currentShipment.isNotEmpty && currentShipment[0].roiKho) {
        fetchShipmentStops();
      }
    });
  }

  Future<void> fetchCurrentShipments() async {
    try {
      isLoading(true);
      update();
      var currentShipments = await HomeService.fetchCurrentShipment(
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');
      if (currentShipments != null) {
        currentShipment.assignAll(currentShipments);
        update();
      } else {
        currentShipment.value = [];
        update();
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> fetchShipmentStops() async {
    try {
      isLoading(true);
      update();
      var shipmentStops = await HomeService.fetchShipmentStops(
          authController.auth.single.driverId,
          currentShipment[0].atMSHIPMENTID,
          currentShipment[0].starTTIME,
          'Bearer ${authController.auth.single.accessToken}');
      if (shipmentStops != null) {
        currentShipmentStops.assignAll(shipmentStops);
        update();
      } else {
        currentShipmentStops.value = [];
        update();
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> updatePickupDepot(String status) async {
    try {
      await locationController.getCurrentLocation().then((_) async {
        final result = await HomeService.updatePickupDepot(
          currentShipment[0].atMSHIPMENTID,
          status,
          'Bearer ${authController.auth.single.accessToken}',
          locationController.currentLat.value.toString(),
          locationController.currentLng.value.toString(),
        );

        if (result == 1) {
          if (status == 'A') {
            currentShipment[0].denKho = true;
          } else if (status == 'P') {
            if (currentShipment[0].denKho) {
              currentShipment[0].startPickup = true;
            } else {
              TextContent.getXSnackBar(
                  '', 'Vui lòng bấm "Đến kho" trước khi "Lấy hàng".', true);
            }
          } else if (status == 'D') {
            if (currentShipment[0].denKho && currentShipment[0].startPickup) {
              currentShipment[0].donePickup = true;
            } else {
              TextContent.getXSnackBar(
                  '', 'Vui lòng bấm "Lấy hàng" trước khi "Lấy xong".', true);
            }
          } else if (status == 'L') {
            if (currentShipment[0].denKho &&
                currentShipment[0].startPickup &&
                currentShipment[0].donePickup) {
              currentShipment[0].roiKho = true;
              fetchShipmentStops();
            } else {
              TextContent.getXSnackBar(
                  '', 'Vui lòng bấm "Lấy xong" trước khi "Rời kho".', true);
            }
          }
        } else if (result == 0) {
          TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
        } else {
          TextContent.getXSnackBar(
              TextContent.internetErrorTitle, TextContent.internetError, true);
        }
      });
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      update();
    }
  }

  Future<void> updateDaToi(
    String storeCode,
    String atmOrderReleaseId,
  ) async {
    try {
      await locationController.getCurrentLocation().then((_) async {
        var result = await HomeService.updateDaToi(
            currentShipment[0].atMSHIPMENTID,
            storeCode,
            atmOrderReleaseId,
            'Bearer ${authController.auth.single.accessToken}',
            locationController.currentLat.value.toString(),
            locationController.currentLng.value.toString());

        if (result == 1) {
          int index = currentShipmentStops
              .indexWhere((stop) => stop.storeCode == storeCode);

          currentShipmentStops[index].daToi = true;
          currentShipmentStops.refresh();
        } else if (result > 1) {
          TextContent.getXSnackBar(
              TextContent.titleWarningDaToi, TextContent.waringDaToi, true);
        } else if (result == 0) {
          TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
        } else {
          TextContent.getXSnackBar(
              TextContent.internetErrorTitle, TextContent.internetError, true);
        }
      });
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      currentShipmentStops.refresh();
    }
  }

  String? validateTenNguoiNhan(String value) {
    if (value.isEmpty) {
      return 'Vui lòng điền đúng tên người nhận hàng.';
    }
    return null;
  }

  String? validateSdtNguoiNhan(String value) {
    if (value.isEmpty) {
      return 'Vui lòng điền đúng số điện thoại người nhận hàng.';
    } else if (value.length != 10 || !value.isNum) {
      return 'số điện thoại phải là 10 kí tự và phải là số';
    }
    return null;
  }

  Future<void> updateContact(
      String atmOrderReleaseId, BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      formKey.currentState!.save();
      isLoadingNguoiNhan(true);

      final result = await HomeService.updateContact(
          atmOrderReleaseId, sdtNguoiNhan.value, tenNguoiNhan.value);

      if (result == 'Ok') {
        Get.back();
      } else {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingNguoiNhan(false);
    }
  }

  Future<void> fetchPersonalContact(
      String locationGid, String customerCode) async {
    try {
      var result =
          await HomeService.fetchPersonalContact(locationGid, customerCode);

      //debugPrint(result.toString());

      if (result.isNotEmpty) {
        tenNguoiNhan.value = result[0].personName;
        sdtNguoiNhan.value = result[0].phone;
        //update();
      } else {
        tenNguoiNhan.value = '';
        sdtNguoiNhan.value = '';
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deliveryHub(
      String storeCode, String atmShipmentId, String atmOrderReleaseId) async {
    try {
      await locationController.getCurrentLocation().then((_) async {
        var result = await HomeService.deliveryHub(
          storeCode,
          authController.auth.single.userName,
          locationController.currentLat.value.toString(),
          locationController.currentLng.value.toString(),
          '',
          '',
          '',
          '',
          atmShipmentId,
          atmOrderReleaseId,
          'Bearer ${authController.auth.single.accessToken}',
        );

        if (result == 'Ok') {
          TextContent.getXSnackBar('', 'Giao Hub thành công', true);
        } else {
          TextContent.getXSnackBar('', 'Giao Hub thất bại', true);
        }
      });
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateStateStopDriver(
      String storeCode,
      String deliveryDate,
      String customer,
      String atmShipmentId,
      int deficient,
      bool enough,
      int broken,
      int redisual,
      int badTemp,
      int realNumDelivered,
      String totalWeight,
      String atmOrderReleaseId,
      int totalCartonMasan) async {
    try {
      if (listImage.isEmpty) {
        TextContent.getXSnackBar(
            '', 'Vui lòng đính kèm ít nhất một hình.', true);
        return;
      }

      isLoadingSaiHang(true);

      locationController.getCurrentLocation().then((_) async {
        var result = await HomeService.updateStateStopDriver(
          'Bearer ${authController.auth.single.accessToken}',
          storeCode,
          deliveryDate,
          customer,
          atmShipmentId,
          deficient,
          enough,
          broken,
          redisual,
          badTemp,
          realNumDelivered,
          totalWeight,
          locationController.currentLat.value.toString(),
          locationController.currentLng.value.toString(),
          atmOrderReleaseId,
          authController.auth.single.userName,
          totalCartonMasan,
          0,
        );

        if (result.contains('Success')) {
          //TextContent.getXSnackBar('', result, true);
          uploadImageChupHinhGiaoHang(
                  storeCode, deliveryDate, noteController.text, 'SC', customer)
              .then((_) {
            listImage.assignAll([]);
            noteController.text = '';
            TextContent.getXSnackBar(
                '', 'Chúc mừng bạn đã hoàn thành xong điểm $storeCode!', true);
            Get.toNamed(AppRoutes.homeLink);
            fetchShipmentStops();
            isLoadingSaiHang(false);
            isLoadingSaiHang.refresh();
          });
        } else {
          TextContent.getXSnackBar('', result, true);
        }
      });
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImageChupHinhGiaoHang(String storeCode,
      String deliveryDate, String note, String type, String customer) async {
    try {
      if (listImage.isNotEmpty) {
        listImage.map((element) async {
          await HomeService.uploadImageChupHinhGiaoHang(
            'Bearer ${authController.auth.single.accessToken}',
            storeCode,
            element,
            deliveryDate,
            authController.auth.single.userName,
            customer,
            note,
            type,
          );
        });
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addADCAD() async {
    try {
      isLoadingADCAD(true);

      var result = await HomeService.addADCADShipment(
        'Bearer ${authController.auth.single.accessToken}',
        currentShipment[0].atMSHIPMENTID,
        DateFormat('yyyy-MM-dd').format(currentShipment[0].starTTIME),
        authController.auth.single.fullName,
        authController.auth.single.driverId,
      );

      //debugPrint(result.toString());

      if (result != 0 && result > -1) {
        if (listImageCompleteShipment.isNotEmpty) {
          for (int i = 0; i < listImageCompleteShipment.length; i++) {
            var resultImage = await HomeService.addADCADImage(
                'Bearer ${authController.auth.single.accessToken}',
                result,
                listImageCompleteShipment[i]);

            //debugPrint(resultImage.toString());

            if (resultImage == 0) {
              TextContent.getXSnackBar('', 'Vui lòng thử lại.', true);
              return;
            }
          }

          await HomeService.updateADCADStateShipment(
                  currentShipment[0].atMSHIPMENTID,
                  authController.auth.single.driverId,
                  'Bearer ${authController.auth.single.accessToken}')
              .then((_) {
            shipmentCompleted();
            isLoadingADCAD(false);
            Get.back();
          });
        } else {
          TextContent.getXSnackBar(
              '', 'Vui lòng đính kèm ít nhất một hình.', true);
        }
      } else {
        isLoadingADCAD(false);
        TextContent.getXSnackBar('', 'Vui lòng thử lại.', true);
        //isLoadingADCAD.refresh();
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingADCAD(false);
      //update();
    }
  }

  Future<void> shipmentCompleted() async {
    try {
      final response = await GiaoChiTietService.shipmentCompleted(
        'Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.driverId,
        DateFormat('yyyy-MM-dd').format(currentShipment[0].starTTIME),
        currentShipment[0].atMSHIPMENTID,
      );

      if (response != null) {
        shipmentCompletedList.assignAll(response);

        if (shipmentCompletedList.isNotEmpty) {
          TextContent.getXSnackBar(
              '',
              'Trong tháng này bạn không nhập app \n${shipmentCompletedList[0].failedTrip} / ${shipmentCompletedList[0].totalTrip} chuyến. Việc này sẽ ảnh hưởng đến thu nhập và thành toán lương của bạn.',
              true);
          fetchCurrentShipments();
          fetchShipmentStops();
          Get.toNamed(AppRoutes.homeLink);
        }
      } else {
        TextContent.getXSnackBar('', 'Vui lòng thử lại sau vài phút.', true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> hoanThanhChuyenBiker() async {
    try {
      isLoadingADCADBiker(true);
      await HomeService.updateADCADStateShipment(
              currentShipment[0].atMSHIPMENTID,
              authController.auth.single.driverId,
              'Bearer ${authController.auth.single.accessToken}')
          .then((_) {
        shipmentCompleted();
        Get.back();
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoadingADCADBiker(false);
    }
  }
}
