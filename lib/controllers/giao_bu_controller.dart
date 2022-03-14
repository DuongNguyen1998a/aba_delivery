import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../models/biker_customer.dart';

// Models
import '../models/giao_bu.dart';
import '../models/giao_bu_detail.dart';

// Services
import '../services/giao_bu_service.dart';

class GiaoBuController extends GetxController {
  final authController = Get.find<AuthController>();
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var giaoBuList = <GiaoBu>[].obs;
  var giaoBuItemList = <GiaoBuDetail>[].obs;
  var bikerCustomerList = <BikerCustomer>[].obs;
  var selectedDropDown = ''.obs;
  final quantityGiaoBuController = TextEditingController(text: '0');

  @override
  void onInit() {
    fetchBikerCustomer().then((_) {
      fetchGiaoBuList(selectedDropDown.value);
    });
    super.onInit();
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
        fetchGiaoBuList(selectedDropDown.value);
      }
    });
  }

  Future<void> fetchGiaoBuList(String customer) async {
    try {
      isLoading(true);

      var result = await GiaoBuService.fetchGiaoBuList(
        'Bearer ${authController.auth.single.accessToken}',
        DateFormat('yyyy-MM-dd').format(selectedDate.value),
        customer,
      );

      if (result != null) {
        giaoBuList.assignAll(result);
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

  Future<void> fetchBikerCustomer() async {
    try {
      var result = await GiaoBuService.fetchBikerCustomer(
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        bikerCustomerList.assignAll(result);
        selectedDropDown.value = bikerCustomerList[0].customerName ?? '';
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchItemDetailGiaoBu(String deliveryDate, String storeCode,
      String customer, String atmShipmentId) async {
    try {
      var result = await GiaoBuService.fetchItemDetailGiaoBu(
        'Bearer ${authController.auth.single.accessToken}',
        deliveryDate,
        storeCode,
        customer,
        atmShipmentId,
      );

      if (result != null) {
        giaoBuItemList.assignAll(result);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateQtyGiaoBu(String rowId, BuildContext context) async {
    try {
      // close keyboard
      FocusScope.of(context).unfocus();

      var result = await GiaoBuService.updateQtyGiaoBu(
        'Bearer ${authController.auth.single.accessToken}',
        rowId,
        int.parse(quantityGiaoBuController.text.toString()),
        authController.auth.single.userName,
      );

      if (result == 'OK') {
        quantityGiaoBuController.text = '0';
        Get.back();
        TextContent.getXSnackBar('', 'Cập nhật SL giao bù thành công.', true);
      } else {
        TextContent.getXSnackBar('', 'Vui lòng thử lại sau ít phút.', true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
