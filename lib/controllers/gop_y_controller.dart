import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

/// Controllers
import '../controllers/auth_controller.dart';

// Models
import '../models/feedback.dart' as fb;
import '../models/shipment_order_payment.dart';

// Services
import '../services/gop_y_service.dart';

class GopYController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final authController = Get.find<AuthController>();
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var fbList = <fb.Feedback>[].obs;
  var title = ''.obs;
  var content = ''.obs;
  var radioGroup = 'Chứng từ, chuyến xe'.obs;
  var shipmentOrderPaymentList = <ShipmentOrderPayment>[].obs;
  var selectedDropdown = ''.obs;

  @override
  void onInit() {
    fetchFeedback();
    super.onInit();
  }

  void onchangedRadio(String val) {
    radioGroup.value = val;
  }

  Future<void> fetchFeedback() async {
    try {
      fbList.assignAll([]);
      isLoading(true);
      var result = await GopYService.fetchFeedback(
        'Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.driverId,
      );

      if (result != null) {
        fbList.assignAll(result);
      } else {
        fbList.assignAll([]);
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

  String? validateTitle(String value) {
    if (value.toString().trim().isEmpty) {
      return 'Tiêu đề không được để trống.';
    }
    return null;
  }

  String? validateContent(String value) {
    if (value.toString().trim().isEmpty) {
      return 'Nội dung không được để trống.';
    }
    return null;
  }

  Future<void> addFeedback(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      formKey.currentState!.save();
      isLoading1(true);

      var result = await GopYService.addFeedback(
        'Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.fullName,
        authController.auth.single.driverId,
        radioGroup.value == 'Khác'
            ? ''
            : selectedDropdown.value == ''
                ? shipmentOrderPaymentList[0].atmShipmentID
                : selectedDropdown.value,
        radioGroup.value,
        content.value,
        title.value,
      );

      if (result == 1) {
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
      isLoading1(false);
    }
  }

  Future<void> fetchShipmentOrderPayment() async {
    try {
      var result = await GopYService.fetchShipmentOrderPayment(
        'Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.driverId,
      );

      if (result != null) {
        shipmentOrderPaymentList.assignAll(result);
      } else {
        shipmentOrderPaymentList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
