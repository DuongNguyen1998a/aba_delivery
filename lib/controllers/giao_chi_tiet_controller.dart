import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Constants
import '../constants/app_routes.dart';
import '../constants/text_content.dart';
/// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/location_controller.dart';
/// Models
import '../models/basket_response.dart';
import '../models/item_booking.dart';
import '../models/phieu_giao_hang.dart';
import '../models/shipment_complete.dart';
/// Services
import '../services/giao_chi_tiet_service.dart';

class GiaoChiTietController extends GetxController {
  var isLoading = false.obs;
  var isChecked = false.obs;
  var countCheckedItem = 0.obs;
  var sumTotalItem = 0.obs;
  var phieuGiaoHangList = <PhieuGiaoHang>[].obs;
  final AuthController authController = Get.find<AuthController>();
  final locationController = Get.find<LocationController>();

  // Khay rổ
  var basketList = <BasketResponse>[].obs;
  GlobalKey<FormState> updateBasketKey =
      GlobalKey(debugLabel: 'updateBasketKey');
  GlobalKey<FormState> updateBasketKey1 =
      GlobalKey(debugLabel: 'updateBasketKey1');
  var basketDeliveryStore = 0.obs;
  var basketReceivedStore = 0.obs;
  final basketDeliveryStoreController = TextEditingController();
  final basketReceivedStoreController = TextEditingController();

  // Khay rổ
  var isLoadingKhayRo = false.obs;

  // update booking
  var bookingList = <ItemBooking>[].obs;

  // update booking

  // shipment completed
  var shipmentCompletedList = <ShipmentComplete>[].obs;

  // final arguments = Get.arguments;
  // var key = 0.obs;

  String atmShipmentId =
      Get.find<HomeController>().currentShipment[0].atMSHIPMENTID;
  DateTime startTime = Get.find<HomeController>().currentShipment[0].starTTIME;

  var helpingStoreController = TextEditingController(text: '');
  var helpingReasonController = TextEditingController(text: '');
  List<TextEditingController> noteControllers = [];

  @override
  void onInit() {
    generateController();

    // if (arguments != null) {
    //   key.value = arguments[0]['key'];
    //   debugPrint(arguments[0]['key'].toString());
    // }
    super.onInit();
  }

  void generateController() {
    for (int i = 0; i < 100; i++) {
      noteControllers.add(TextEditingController());
    }
  }

  void onChangedCbThieu(int index, int key, bool value) {
    if (key == 1) {
      phieuGiaoHangList[index].cbThieu = value;
      if (!value) {
        phieuGiaoHangList[index].slGiaoCH +=
            phieuGiaoHangList[index].valueCbThieu;
        phieuGiaoHangList[index].valueCbThieu = 0;
      }
    } else if (key == 2) {
      phieuGiaoHangList[index].cbDu = value;
      if (!value) {
        phieuGiaoHangList[index].slGiaoCH += phieuGiaoHangList[index].valueCbDu;
        phieuGiaoHangList[index].valueCbDu = 0;
      }
    } else if (key == 3) {
      phieuGiaoHangList[index].cbTraVe = value;
      if (!value) {
        phieuGiaoHangList[index].slGiaoCH +=
            phieuGiaoHangList[index].valueCbTraVe;
        phieuGiaoHangList[index].valueCbTraVe = 0;
      }
    }
    phieuGiaoHangList.refresh();
  }

  void btnTruThieu(int index, int key) {
    if (key == 1) {
      if (phieuGiaoHangList[index].cbThieu) {
        if (phieuGiaoHangList[index].valueCbThieu > 0) {
          phieuGiaoHangList[index].valueCbThieu--;
          phieuGiaoHangList[index].slGiaoCH++;
        }
      }
    } else if (key == 2) {
      if (phieuGiaoHangList[index].cbDu) {
        if (phieuGiaoHangList[index].valueCbDu > 0) {
          phieuGiaoHangList[index].valueCbDu--;
          phieuGiaoHangList[index].slGiaoCH++;
        }
      }
    } else if (key == 3) {
      if (phieuGiaoHangList[index].cbTraVe) {
        if (phieuGiaoHangList[index].valueCbTraVe > 0) {
          phieuGiaoHangList[index].valueCbTraVe--;
          phieuGiaoHangList[index].slGiaoCH++;
        }
      }
    }
    phieuGiaoHangList.refresh();
  }

  void btnCongThieu(int index, int key) {
    if (key == 1) {
      if (phieuGiaoHangList[index].cbThieu) {
        if (phieuGiaoHangList[index].slGiaoCH != 0) {
          phieuGiaoHangList[index].valueCbThieu++;
          phieuGiaoHangList[index].slGiaoCH--;
        }
      }
    } else if (key == 2) {
      if (phieuGiaoHangList[index].cbDu) {
        if (phieuGiaoHangList[index].slGiaoCH != 0) {
          phieuGiaoHangList[index].valueCbDu++;
          phieuGiaoHangList[index].slGiaoCH--;
        }
      }
    } else if (key == 3) {
      if (phieuGiaoHangList[index].cbTraVe) {
        if (phieuGiaoHangList[index].slGiaoCH != 0) {
          phieuGiaoHangList[index].valueCbTraVe++;
          phieuGiaoHangList[index].slGiaoCH--;
        }
      }
    }
    phieuGiaoHangList.refresh();
  }

  Future<void> fetchPhieuGiaoHang(
      String storeCode, String date, String customerCode) async {
    try {
      isLoading(true);
      var result = await GiaoChiTietService.fetchPhieuGiaoHang(storeCode, date,
          customerCode, 'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        phieuGiaoHangList.assignAll(result);

        sumTotalItem.value = 0;
        phieuGiaoHangList.map((element) {
          sumTotalItem.value += element.soBich.toInt();
        }).toList();
      } else {
        phieuGiaoHangList.value = [];
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

  void itemChecked(int index) {
    if (phieuGiaoHangList[index].isChecked) {
      phieuGiaoHangList[index].isChecked = false;
      if (countCheckedItem.value != 0) {
        countCheckedItem.value--;
      }
    } else {
      phieuGiaoHangList[index].isChecked = true;
      countCheckedItem.value++;
    }
    phieuGiaoHangList.refresh();
  }

  void checkedAllItem() {
    phieuGiaoHangList.map((element) {
      element.isChecked = true;
    }).toList();
    countCheckedItem.value = phieuGiaoHangList.length;
    phieuGiaoHangList.refresh();
  }

  Future<void> sendItem(String atmOrderReleaseId) async {
    if (countCheckedItem.value != phieuGiaoHangList.length) {
      TextContent.getXSnackBar('', 'Vui lòng kiểm tra đầy đủ đơn hàng', true);
      return;
    } else {
      //debugPrint(atmOrderReleaseId);
      var result = await GiaoChiTietService.fetchQuantityBasket(
          atmOrderReleaseId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        basketList.assignAll(result);
        Get.toNamed(AppRoutes.basketLink, arguments: [
          {'key': 2}
        ]);
      } else {
        TextContent.getXSnackBar('', 'Không có thông tin khay rổ', true);
        return;
      }
    }
  }

  Future<void> shipmentCompleted() async {
    try {
      final response = await GiaoChiTietService.shipmentCompleted(
        'Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.driverId,
        DateFormat('yyyy-MM-dd').format(startTime),
        atmShipmentId,
      );

      if (response != null) {
        shipmentCompletedList.assignAll(response);

        //debugPrint(shipmentCompletedList[0].totalDrop);

        if (shipmentCompletedList.isNotEmpty) {
          TextContent.getXSnackBar(
              '',
              'Chúc mừng bạn đã hoàn thành được \n${shipmentCompletedList[0].dropCompleted} / ${shipmentCompletedList[0].totalDrop} điểm giao.',
              true);
          Get.find<HomeController>().fetchShipmentStops();
          isLoadingKhayRo(false);
          isLoadingKhayRo.refresh();
          Get.delete<GiaoChiTietController>();
          Get.delete<HomeController>();
          Get.toNamed(AppRoutes.homeLink);
          // if (key == 1) {
          //
          // }
          // // else {
          //   TextContent.getXSnackBar(
          //       '',
          //       'Trong tháng này bạn không nhập app ${shipmentCompletedList[0].failedTrip} / ${shipmentCompletedList[0].totalTrip} chuyến. \n Việc này sẽ ảnh hưởng đến thu nhập và thành toán lương của bạn.',
          //       true);
          //   //Get.delete<GiaoChiTietController>();
          //   //Get.delete<HomeController>();
          //   Get.toNamed(AppRoutes.homeLink);
          // }
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

  void updateNotes() {}

  Future<void> updateBooking() async {
    try {
      if (phieuGiaoHangList.isNotEmpty) {
        locationController.getCurrentLocation().then((_) async {
          for (var item in phieuGiaoHangList) {
            bookingList.add(ItemBooking(
              iD: item.xdocKDocEntry.toString(),
              actualReceived: item.slGiaoCH.toInt(),
              actualWeightReceived: ((item.soKi / item.soBich) * item.slGiaoCH),
              notes: item.notes,
              updatedByDeliverer: authController.auth.single.userName,
              latDelivered: locationController.currentLat.value.toString(),
              lngDelivered: locationController.currentLng.value.toString(),
              helpingStore: isChecked.value ? helpingStoreController.text : '',
              helpingReason:
                  isChecked.value ? helpingReasonController.text : '',
              incompliance: item.valueCbThieu,
              residual: item.valueCbDu,
              returnee: item.valueCbTraVe,
              aTMShipmentID: atmShipmentId,
            ));
          }

          //debugPrint(bookingList[0].toJson().toString());

          var resultUpdateBooking = await GiaoChiTietService.updateBooking(
              'Bearer ${authController.auth.single.accessToken}', bookingList);

          if (resultUpdateBooking == 1) {
            debugPrint(resultUpdateBooking.toString());
            //TextContent.getXSnackBar('', 'Cập nhật thành công.', true);
            // Call function hoàn thành điểm giao
            await shipmentCompleted().then((_) {
              //Get.lazyPut(()=>HomeController());
            });
          } else {
            TextContent.getXSnackBar('', 'Vui lòng thử lại', true);
          }
        });
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateBasketQuantity(BuildContext context, int key) async {
    try {

      //debugPrint('My Key: ${key.toString()}');

      isLoadingKhayRo(true);

      if (key == 2) {
        if (!updateBasketKey1.currentState!.validate()) {
          return;
        }

        // close keyboard
        FocusScope.of(context).unfocus();
        // saved Form
        updateBasketKey1.currentState!.save();
      } else {
        if (!updateBasketKey.currentState!.validate()) {
          return;
        }

        // close keyboard
        FocusScope.of(context).unfocus();
        // saved Form
        updateBasketKey.currentState!.save();
      }

      if (basketList.isNotEmpty) {
        for (var item in basketList) {
          await GiaoChiTietService.updateQuantityBasket(
            'Bearer ${authController.auth.single.accessToken}',
            item.id,
            item.quantityConfirmSendStore ?? 0,
            item.quantityConfirmReceivedStore ?? 0,
          );

          //debugPrint(result.toString());
        }
        if (key == 2) {
          // call function này sau khi update khay rổ
          updateBooking();
        } else {
          await shipmentCompleted().then((_) {
            //Get.toNamed(AppRoutes.homeLink);
          });
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchQuantityBasket(String atmOrderReleaseId) async {
    try {
      var result = await GiaoChiTietService.fetchQuantityBasket(
          atmOrderReleaseId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        basketList.assignAll(result);
        Get.toNamed(AppRoutes.basketLink, arguments: [
          {'key': 1}
        ]);
      } else {
        TextContent.getXSnackBar('', 'Không có thông tin khay rổ', true);
        return;
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
