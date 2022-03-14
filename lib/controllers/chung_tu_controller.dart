import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../models/license.dart';

// Models
import '../models/location_atm_id.dart';

// Service
import '../services/chung_tu_service.dart';

class ChungTuController extends GetxController {
  final authController = Get.find<AuthController>();
  var selectedDate = DateTime
      .now()
      .obs;
  var isLoading = false.obs;
  var isLoadingForm = false.obs;
  var isLoadingList = false.obs;
  var isLoadingEdit = false.obs;
  var isLoadingDelete = false.obs;
  var atmShipmentIdList = <LocationATMId>[].obs;
  var licenseList = <License>[].obs;
  var currentShipment = ''.obs;
  var note = ''.obs;
  final textController = TextEditingController();
  final GlobalKey<FormState> licenseForm = GlobalKey();
  final GlobalKey<FormState> licenseEditForm = GlobalKey();

  @override
  void onInit() {
    selectedDate.value = DateTime.now();
    fetchLicenseList();
    fetchLocationATMShipmentId().then((_) {
      if (atmShipmentIdList.isNotEmpty) {
        currentShipment.value = atmShipmentIdList[0].atMSHIPMENTID;
      }
    });
    super.onInit();
  }

  void openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      locale: const Locale('vi', 'VN'),
      initialDate: selectedDate.value,
      firstDate: DateTime(selectedDate.value.year, selectedDate.value.month,
          selectedDate.value.day),
      lastDate: DateTime(selectedDate.value.year, selectedDate.value.month,
          selectedDate.value.day + 3),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        selectedDate.value = pickedDate;
      }
    });
  }

  void openDatePickerEdit(BuildContext context, DateTime initDate) {
    showDatePicker(
      context: context,
      locale: const Locale('vi', 'VN'),
      initialDate: initDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(9999),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        textController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      }
    });
  }

  Future<void> fetchLocationATMShipmentId() async {
    try {
      isLoading(true);
      var result = await ChungTuService.fetchLocationATMShipmentId(
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        atmShipmentIdList.assignAll(result);
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

  LocationATMId getDataFromCurrentShipment(String atmShipment) {
    return atmShipmentIdList
        .where((p0) => p0.atMSHIPMENTID == atmShipment)
        .single;
  }

  String getDateOfFilling() {
    var currentDate = DateTime.now();
    var dateOfFilling =
    DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    return DateFormat('dd/MM/yyyy').format(dateOfFilling);
  }

  Future<void> createNewLicense(BuildContext context) async {
    try {
      if (atmShipmentIdList.isEmpty) {
        TextContent.getXSnackBar('', 'Không có mã chuyến không thể gửi', true);
        return;
      }

      if (!licenseForm.currentState!.validate()) {
        return;
      } else {
        // Save form
        licenseForm.currentState!.save();

        // close keyboard
        FocusScope.of(context).unfocus();
        // waiting
        isLoadingForm(true);

        var result = await ChungTuService.createNewLicense(
            'Bearer ${authController.auth.single.accessToken}',
            currentShipment.value,
            getDataFromCurrentShipment(currentShipment.value).customerCode ??
                'Khách hàng ghép',
            getDataFromCurrentShipment(currentShipment.value).startTime,
            authController.auth.single.driverId,
            getDateOfFilling(),
            note.value,
            authController.auth.single.fullName,
            authController.auth.single.region,
            authController.auth.single.site);

        if (result.contains("Gửi thành công!")) {
          fetchLicenseList();
          Get.back();
        } else if (result.contains("Error API")) {
          TextContent.getXSnackBar(TextContent.errorResponseFail,
              TextContent.errorResponseFail, true);
        } else {
          TextContent.getXSnackBar('', result, true);
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingForm(false);
    }
  }

  Future<void> fetchLicenseList() async {
    try {
      isLoadingList(true);

      var result = await ChungTuService.fetchLicenseList(
          'Bearer ${authController.auth.single.accessToken}',
          authController.auth.single.driverId);

      if (result != null) {
        licenseList.assignAll(result);
      }
      else {
        licenseList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingList(false);
    }
  }

  Future<void> editLicense(int id) async {
    try {
      if (!licenseEditForm.currentState!.validate()) {
        return;
      }

      licenseEditForm.currentState!.save();

      isLoadingEdit(true);

      var stringDate = DateFormat('yyyy-MM-dd').format(DateFormat("dd/MM/yyyy").parse(textController.text));


      var result = await ChungTuService.editLicense(
          'Bearer ${authController.auth.single.accessToken}',
          id,
          note.value,
          stringDate);

      if (result.contains("Sửa Thành Công!")) {
        fetchLicenseList();
      } else if (result.contains("Error API")) {
        TextContent.getXSnackBar(
            TextContent.errorResponseFail, TextContent.errorResponseFail, true);
      } else {
        TextContent.getXSnackBar('', result, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingEdit(false);
    }
  }

  Future<void> deleteLicense(int id) async {
    try {

      isLoadingDelete(true);

      var result = await ChungTuService.deleteLicense(
          'Bearer ${authController.auth.single.accessToken}',
          id);

      if (result.contains("Xóa Thành Công!")) {
        fetchLicenseList();
      } else if (result.contains("Error API")) {
        TextContent.getXSnackBar(
            TextContent.errorResponseFail, TextContent.errorResponseFail, true);
      } else {
        TextContent.getXSnackBar('', result, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
    finally {
      isLoadingDelete(false);
    }
  }
}