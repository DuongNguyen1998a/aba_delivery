import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Models
import '../models/history.dart';
import '../models/history_delivery_detail.dart';
import '../models/history_detail.dart';
import '../models/history_delivery.dart';

// Services
import '../services/lich_su_giao_hang_service.dart';

// Widgets
import 'package:month_picker_dialog/month_picker_dialog.dart' as date_picker;

class LichSuGiaoHangController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var selectedDate = DateTime.now().obs;
  var selectedDate1 = DateTime.now().obs;
  var historyList = <History>[].obs;
  var historyDetailList = <HistoryDetail>[].obs;
  var historyDeliveryList = <HistoryDelivery>[].obs;
  var historyDeliveryDetailList = <HistoryDeliveryDetail>[].obs;
  var isLoading = false.obs;
  var isLoadingDetail = false.obs;
  var isLoadingDelivery = false.obs;
  var isLoadingDeliveryDetail = false.obs;
  var totalAmount = 0.0.obs;
  var totalAmountDetail = 0.0.obs;

  @override
  void onInit() {
    fetchHistorySalary(2021, 12);
    fetchHistoryDelivery();
    super.onInit();
  }

  int compareDateTime(int index) {
    if (DateTime.parse(historyDeliveryList[index].deliveryTime).millisecond <=
        DateTime.parse(historyDeliveryList[index].endTime).millisecond) {
      return 1;
    } else {
      return 2;
    }
  }

  void openMonthYearPicker(BuildContext context) {
    date_picker
        .showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedDate.value,
      locale: const Locale('vi', 'VN'),
    )
        .then((date) {
      if (date == null) {
        return;
      } else {
        selectedDate.value = date;
        fetchHistorySalary(date.year, date.month);
      }
    });
  }

  void openMonthYearPicker1(BuildContext context) {
    date_picker
        .showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedDate1.value,
      locale: const Locale('vi', 'VN'),
    )
        .then((date) {
      if (date == null) {
        return;
      } else {
        selectedDate1.value = date;
        fetchHistoryDelivery();
      }
    });
  }

  Future<void> fetchHistorySalary(
    int year,
    int month,
  ) async {
    try {
      isLoading(true);

      var result = await LichSuGiaoHangService.fetchHistorySalary(
        year,
        month,
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        historyList.assignAll(result);

        totalAmount.value = 0;
        historyList
            .map((element) => totalAmount.value += element.salary)
            .toList();
      } else {
        historyList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchHistorySalaryDetail(String atmShipmentId) async {
    try {
      isLoadingDetail(true);
      var result = await LichSuGiaoHangService.fetchHistorySalaryDetail(
        atmShipmentId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        historyDetailList.assignAll(result);

        totalAmountDetail.value = 0;

        if (historyDetailList.isNotEmpty) {
          historyDetailList
              .map((element) =>
                  {totalAmountDetail.value += element.salarYAMOUNT!})
              .toList();
        }
      } else {
        historyDetailList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingDetail(false);
    }
  }

  Future<void> fetchHistoryDelivery() async {
    try {
      isLoadingDelivery(true);
      var result = await LichSuGiaoHangService.fetchHistoryDelivery(
          selectedDate1.value.month,
          selectedDate1.value.year,
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        historyDeliveryList.assignAll(result);
      } else {
        historyDeliveryList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingDelivery(false);
    }
  }

  Future<void> fetchHistoryDeliveryDetail(String atmShipmentId) async {
    try {
      isLoadingDeliveryDetail(true);
      var result = await LichSuGiaoHangService.fetchHistoryDeliveryDetail(
          atmShipmentId, 'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        historyDeliveryDetailList.assignAll(result);
      } else {
        historyDeliveryDetailList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingDeliveryDetail(false);
    }
  }

  int isShow(int index) {
    if (historyDeliveryDetailList[index].khachHang == 'MASAN' ||
        historyDeliveryDetailList[index].khachHang == 'TOKYODELI' ||
        historyDeliveryDetailList[index].khachHang == '14111' ||
        historyDeliveryDetailList[index].khachHang == 'VCMFRESH' ||
        historyDeliveryDetailList[index].khachHang == 'NEWZEALAND' ||
        historyDeliveryDetailList[index].khachHang == '3F_VIETFOOD' ||
        historyDeliveryDetailList[index].khachHang == '1000331' ||
        historyDeliveryDetailList[index].khachHang == '6020') {
      if (historyDeliveryDetailList[index].khachHang == '14111' ||
          historyDeliveryDetailList[index].khachHang == 'VCMFRESH' ||
          historyDeliveryDetailList[index].khachHang == 'NEWZEALAND' ||
          historyDeliveryDetailList[index].khachHang == '3F_VIETFOOD' ||
          historyDeliveryDetailList[index].khachHang == '1000331' ||
          historyDeliveryDetailList[index].khachHang == '6020') {
        return 1;
      } else {
        return 2;
      }
    } else {
      return 2;
    }
  }
}
