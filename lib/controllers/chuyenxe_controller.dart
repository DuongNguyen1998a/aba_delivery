import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

// Models
import '../models/shipment.dart';
import '../models/shipment_stop.dart';

// Services
import '../services/chuyenxe_service.dart';

class ChuyenXeController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> deniedShipmentKey = GlobalKey();
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var key = 1.obs;
  var assignedShipments = <Shipment>[].obs;
  var acceptedShipments = <Shipment>[].obs;
  var reasonDeniedShipment = ''.obs;
  var checkShipmentStops = <ShipmentStop>[].obs;

  @override
  void onInit() {
    fetchShipments(key.value);
    fetchShipments(2);
    super.onInit();
  }

  void showDatePickerDialog(BuildContext context) {
    showDatePicker(
      context: context,
      locale: const Locale('vi', 'VN'),
      initialDate: selectedDate.value,
      firstDate: DateTime(2018),
      lastDate: DateTime(9999),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        selectedDate.value = pickedDate;
        fetchShipments(key.value);
        fetchShipments(2);
      }
    });
  }

  void nextDate() {
    selectedDate.value = selectedDate.value.add(const Duration(days: 1));
    fetchShipments(1);
    fetchShipments(2);
  }

  void previousDate() {
    selectedDate.value = selectedDate.value.add(const Duration(days: -1));
    fetchShipments(1);
    fetchShipments(2);
  }

  Future<void> fetchShipments(int key) async {
    try {
      isLoading(true);
      var shipments = await ChuyenXeService.fetchShipmentByMode(
          key,
          authController.auth.single.driverId,
          DateFormat('yyyy-MM-dd').format(selectedDate.value),
          DateFormat('yyyy-MM-dd').format(selectedDate.value),
          'Bearer ${authController.auth.single.accessToken}');
      if (shipments != null && key == 1) {
        assignedShipments.assignAll(shipments);
      } else if (shipments != null && key == 2) {
        acceptedShipments.assignAll(shipments);
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

  String? validateReasonDeniedShipment(String reason) {
    if (reason.isEmpty || reason.toString().trim() == '') {
      return 'Lí do không được bỏ trống.';
    }
    return null;
  }

  Future<void> deniedShipment(String atmShipmentId, DateTime deliveryDate,
      String routeNo, String reason, BuildContext context) async {
    try {
      if (!deniedShipmentKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      deniedShipmentKey.currentState!.save();
      isLoading(true);
      final result = await ChuyenXeService.deniedShipment(
        atmShipmentId,
        deliveryDate,
        routeNo,
        reason,
        ' Bearer ${authController.auth.single.accessToken}',
        authController.auth.single.driverId,
        authController.auth.single.fullName,
      );

      if (result == 1) {
        fetchShipments(1);
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
      isLoading(false);
    }
  }

  Future<void> acceptedShipment(String atmShipmentId) async {
    try {
      isLoading(true);
      final result = await ChuyenXeService.acceptedShipment(
          atmShipmentId,
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result == 1) {
        fetchShipments(1);
        fetchShipments(2);
      } else {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
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

  Future<void> startShipment(String atmShipmentId) async {
    try {
      isLoading(true);
      final result = await ChuyenXeService.startShipment(
          atmShipmentId,
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result == 1) {
        Get.delete<HomeController>();
        Get.toNamed(AppRoutes.homeLink);
      } else if (result == 0) {
        TextContent.getXSnackBar('', TextContent.errorWhenStartShipment, true);
      } else {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
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

  Future<void> fetchCheckShipmentStops(
      String atmShipmentId, DateTime date) async {
    try {
      isLoading(true);
      final shipmentStops = await ChuyenXeService.fetchShipmentStops(
          authController.auth.single.driverId,
          atmShipmentId,
          date,
          'Bearer ${authController.auth.single.accessToken}');

      if (shipmentStops != null) {
        checkShipmentStops.assignAll(shipmentStops);
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
}
