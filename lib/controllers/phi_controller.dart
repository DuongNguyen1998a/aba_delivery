import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart' as date_picker;

import '../constants/app_routes.dart';

// Constants
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Models
import '../models/de_nghi_tam_ung.dart';
import '../models/de_nghi_thanh_toan.dart';
import '../models/de_nghi_thanh_toan_detail.dart';
import '../models/expense_attachment.dart';
import '../models/fee_type.dart';
import '../models/result_image.dart';
import '../models/shipment_advance_payment.dart';

// Services
import '../services/phi_service.dart';

class PhiController extends GetxController {
  final authController = Get.find<AuthController>();
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;
  var isLoading4 = false.obs;
  var selectedDate = DateTime.now().obs;
  var selectedDate1 = DateTime.now().obs;
  var tamUngList = <DeNghiTamUng>[].obs;
  var thanhToanList = <DeNghiThanhToan>[].obs;
  var thanhToanDetailList = <DeNghiThanhToanDetail>[].obs;
  var expenseImageList = <ExpenseAttachment>[].obs;
  var totalConLai = 0.obs;

  // Dialog EditTamUng
  final GlobalKey<FormState> dialogEditTamUngKey = GlobalKey();

  // Dialog EditTamUng

  // Add Đề Nghị Tạm Ứng
  var isLoading5 = false.obs;
  final GlobalKey<FormState> tamUngKey = GlobalKey();
  var feeTypeList = <FeeType>[].obs;
  var shipmentAdvancePaymentList = <ShipmentAdvancePayment>[].obs;
  final ImagePicker imagePicker = ImagePicker();
  var imageTamUngList = <XFile?>[].obs;
  var selectedDropdown = 1.obs;
  var selectedDropdown1 = ''.obs;
  var resultImageList = <ResultImage>[].obs;

  FeeType? getFeeType(int id) {
    if (feeTypeList.isNotEmpty) {
      return feeTypeList.where((p0) => p0.id == id).toList().single;
    } else {
      return null;
    }
  }

  ShipmentAdvancePayment? getShipmentAdvancePayment(String atmShipmentId) {
    if (shipmentAdvancePaymentList.isNotEmpty) {
      return shipmentAdvancePaymentList
          .where((p0) => p0.atmShipmentID == atmShipmentId)
          .toList()
          .single;
    } else {
      return null;
    }
  }

  var amountTamUng = 0.obs;
  var noteTamUng = ''.obs;

  void pickImageClick() async {
    final XFile? mPickImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );

    if (mPickImage != null) {
      imageTamUngList.add(mPickImage);
    }
  }

  void pickImageClick1(int index) async {
    final XFile? mPickImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );

    if (mPickImage != null) {
      addImageTamUng(tamUngList[index].id, tamUngList[index].atmShipmentID!,
          tamUngList[index].advancePaymentType, mPickImage);
    }
  }

  void takePhotoClick() async {
    final XFile? mTakePhoto = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakePhoto != null) {
      imageTamUngList.add(mTakePhoto);
    }
  }

  void takePhotoClick1(int index) async {
    final XFile? mTakePhoto = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakePhoto != null) {
      addImageTamUng(tamUngList[index].id, tamUngList[index].atmShipmentID!,
              tamUngList[index].advancePaymentType, mTakePhoto)
          .then((_) => fetchExpenseImage(tamUngList[index].id));
    }
  }

  void openDialogCamera() {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          TextButton(
            onPressed: () {
              pickImageClick();
            },
            child: const Text('Chọn ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              takePhotoClick();
            },
            child: const Text('Chụp hình'),
          ),
        ],
      ),
    );
  }

  void openDialogCamera1(int index) {
    if (tamUngList[index].manager != 'CHỜ XỬ LÝ') {
      TextContent.getXSnackBar('', 'Không thể thêm ảnh phí này', true);
      return;
    } else {
      Get.defaultDialog(
        title: '',
        content: Column(
          children: [
            TextButton(
              onPressed: () {
                pickImageClick1(index);
              },
              child: const Text('Chọn ảnh từ thư viện'),
            ),
            TextButton(
              onPressed: () {
                takePhotoClick1(index);
              },
              child: const Text('Chụp hình'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> fetchFeeType() async {
    try {
      var result = await PhiService.fetchFeeType(
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        feeTypeList.assignAll(result);
      } else {
        feeTypeList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchShipmentAdvPayment() async {
    try {
      var result = await PhiService.fetchShipmentAdvancePayment(
          authController.auth.single.driverId,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        shipmentAdvancePaymentList.assignAll(result);
      } else {
        shipmentAdvancePaymentList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendTamUng(BuildContext context) async {
    try {
      //debugPrint('Call sendTamUng();');
      var dropDownFee = getFeeType(selectedDropdown.value)!;
      String atmShipmentId = '';

      if (dropDownFee.abbreviations == ' ') {
        if (shipmentAdvancePaymentList.isEmpty) {
          TextContent.getXSnackBar(
            '',
            'Thất bại! Tạm Ứng Phí Đi Đường cần có mã chuyến',
            true,
          );
          return;
        } else {
          atmShipmentId = selectedDropdown1.value;
          if (!tamUngKey.currentState!.validate()) {
            // Invalid!
            return;
          }
          // close keyboard
          FocusScope.of(context).unfocus();
          // saved form
          tamUngKey.currentState!.save();
          isLoading5(true);

          var result = await PhiService.sendTamUng(
            'Bearer ${authController.auth.single.accessToken}',
            atmShipmentId,
            '',
            // OtmShipmentId
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                            ? shipmentAdvancePaymentList[0].atmShipmentID
                            : selectedDropdown1.value)!
                        .powerUnitGID ??
                    '',
            authController.auth.single.driverId,
            authController.auth.single.fullName,
            authController.auth.single.region == 'MN'
                ? '2001-TRUCKING'
                : '2002-TRUCKING',
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .customerCode,
            authController.auth.single.region == 'MN'
                ? 'TMN-ADV-${DateFormat('yyMMdd').format(DateTime.now())}-${dropDownFee.abbreviations != ' ' ? dropDownFee.abbreviations : ''}'
                : 'TMB-ADV-${DateFormat('yyMMdd').format(DateTime.now())}-${dropDownFee.abbreviations != ' ' ? dropDownFee.abbreviations : ''}',
            dropDownFee.feeName,
            noteTamUng.value,
            amountTamUng.value.toString(),
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .city,

            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .startTime,
          );

          if (result == 0) {
            TextContent.getXSnackBar(
              '',
              'Thất bại! Mã chuyến này đã có tạm ứng phí đi đường trước đó.',
              true,
            );
          } else if (result == 1) {
            Get.offNamed(AppRoutes.deNghiTamUngLink);
            fetchDeNghiTamUng();
          } else {
            TextContent.getXSnackBar(
              '',
              TextContent.errorResponseFail,
              true,
            );
          }
        }
      } else if (dropDownFee.abbreviations == 'BT' ||
          dropDownFee.abbreviations == 'K') {
        if (imageTamUngList.isEmpty) {
          TextContent.getXSnackBar(
            '',
            'Vui lòng chụp ít nhất một hình đối với Phí Bồi Thường và Phí Khác',
            true,
          );
          return;
        } else {
          // close keyboard
          FocusScope.of(context).unfocus();
          // saved form
          tamUngKey.currentState!.save();
          isLoading5(true);

          var result = await PhiService.sendTamUng(
            'Bearer ${authController.auth.single.accessToken}',
            atmShipmentId,
            '',
            // OtmShipmentId
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                            ? shipmentAdvancePaymentList[0].atmShipmentID
                            : selectedDropdown1.value)!
                        .powerUnitGID ??
                    '',
            authController.auth.single.driverId,
            authController.auth.single.fullName,
            authController.auth.single.region == 'MN'
                ? '2001-TRUCKING'
                : '2002-TRUCKING',
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .customerCode,
            authController.auth.single.region == 'MN'
                ? 'TMN-ADV-${DateFormat('yyMMdd').format(DateTime.now())}-${dropDownFee.abbreviations != ' ' ? dropDownFee.abbreviations : ''}'
                : 'TMB-ADV-${DateFormat('yyMMdd').format(DateTime.now())}-${dropDownFee.abbreviations != ' ' ? dropDownFee.abbreviations : ''}',
            dropDownFee.feeName,
            noteTamUng.value,
            amountTamUng.value.toString(),
            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .city,

            dropDownFee.abbreviations == 'L'
                ? ''
                : getShipmentAdvancePayment(selectedDropdown1.value == ''
                        ? shipmentAdvancePaymentList[0].atmShipmentID
                        : selectedDropdown1.value)!
                    .startTime,
          );

          if (result == 0) {
            TextContent.getXSnackBar(
              '',
              'Thất bại! Mã chuyến này đã có tạm ứng phí đi đường trước đó.',
              true,
            );
          } else if (result == 1) {
            Get.back();
            fetchDeNghiTamUng();
          } else {
            TextContent.getXSnackBar(
              '',
              TextContent.errorResponseFail,
              true,
            );
          }
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
        TextContent.internetErrorTitle,
        TextContent.internetError,
        true,
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading5(false);
    }
  }

  // Add Đề Nghị Tạm Ứng

  @override
  void onInit() {
    fetchDeNghiTamUng();
    //fetchDeNghiThanhToan();
    super.onInit();
  }

  int getTotalConLai() {
    if (thanhToanList.isNotEmpty) {
      totalConLai.value = 0;
      thanhToanList.map((item) {
        totalConLai += item.amountTotal - item.amount;
      }).toList();
      return totalConLai.value;
    }
    return 0;
  }

  String getOP_OrTechnicalStatus(index) {
    if (thanhToanDetailList.isNotEmpty) {
      if (thanhToanDetailList[index].advancePaymentType ==
          'PHÍ VÁ VỎ, SỬA XE') {
        return 'Kĩ thuật: ';
      } else {
        return 'OP: ';
      }
    }
    return '';
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
        fetchDeNghiTamUng();
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
        fetchDeNghiThanhToan();
        //getTotalConLai();
      }
    });
  }

  Future<void> fetchDeNghiTamUng() async {
    try {
      isLoading(true);
      var result = await PhiService.fetchDeNghiTamUng(
        selectedDate.value.month.toString(),
        selectedDate.value.year.toString(),
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        tamUngList.assignAll(result);
      } else {
        tamUngList.assignAll([]);
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

  Future<void> fetchDeNghiThanhToan() async {
    try {
      isLoading1(true);
      var result = await PhiService.fetchDeNghiThanhToan(
        selectedDate1.value.month.toString(),
        selectedDate1.value.year.toString(),
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        thanhToanList.assignAll(result);
      } else {
        thanhToanList.assignAll([]);
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

  Future<void> fetchThanhToanDetail(String atmShipmentId) async {
    try {
      isLoading2(true);

      var result = await PhiService.fetchDeNghiThanhToanDetail(
          atmShipmentId, 'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        thanhToanDetailList.assignAll(result);
      } else {
        thanhToanDetailList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading2(false);
    }
  }

  Future<void> fetchExpenseImage(int id) async {
    try {
      //debugPrint('Call function fetchExpenseImage() $id');
      isLoading3(true);

      var result = await PhiService.fetchImages(
          id, 'Bearer ${authController.auth.single.accessToken}');

      //debugPrint(result.toString());

      if (result != null) {
        expenseImageList.assignAll(result);
        //debugPrint(result.toList().toString());
      } else {
        expenseImageList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading3(false);
    }
  }

  Future<void> fetchExpenseImage1(int id) async {
    try {
      isLoading4(true);

      var result = await PhiService.fetchImages(
          id, 'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        expenseImageList.assignAll(result);
      } else {
        expenseImageList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading4(false);
    }
  }

  Future<void> updateTamUng(int index) async {
    try {
      if (tamUngList[index].manager != 'CHỜ XỬ LÝ') {
        TextContent.getXSnackBar(
            '', 'Phí tạm ứng đã được duyệt, không sửa được phí.', true);
        return;
      }

      var result = await PhiService.updateTamUng(
          'Bearer ${authController.auth.single.accessToken}',
          tamUngList[index].atmShipmentID!,
          amountTamUng.value,
          noteTamUng.value,
          tamUngList[index].advancePaymentType);

      if (result == 1) {
        Get.back();
        Get.toNamed(AppRoutes.deNghiTamUngLink);
        fetchDeNghiTamUng();
      } else if (result == 0) {
        // Get.back();
        // Get.toNamed(AppRoutes.deNghiTamUngLink);
        // fetchDeNghiTamUng();
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      } else if (result == -1) {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTamUng(int index) async {
    try {
      var result = await PhiService.deleteTamUng(
          'Bearer ${authController.auth.single.accessToken}',
          tamUngList[index].id,
          tamUngList[index].advancePaymentType);

      if (result == 1) {
        Get.back();
        Get.offAndToNamed(AppRoutes.deNghiTamUngLink);
        fetchDeNghiTamUng();
      } else if (result == 0) {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      } else if (result == -1) {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addImageTamUng(
      int id, String atmShipmentId, String documentType, XFile mFile) async {
    try {
      await PhiService.addImageTamUng(id, atmShipmentId, documentType, mFile,
          'Bearer ${authController.auth.single.accessToken}');

      Get.back();
      Get.back();

      fetchExpenseImage(id);
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImageTamUng(int index, int id) async {
    try {
      if (expenseImageList.isEmpty) {
        TextContent.getXSnackBar('', 'Không có hình để xóa.', true);
        return;
      }
      var result = await PhiService.deleteImageTamUng(
        'Bearer ${authController.auth.single.accessToken}',
        tamUngList[index].id,
        expenseImageList[expenseImageList.length - 1].attachName,
        tamUngList[index].advancePaymentType,
      );

      if (result == 'Xóa thành công.') {
        Get.back();
        fetchExpenseImage(tamUngList[index].id);
      } else if (result == 'Error') {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      } else {
        TextContent.getXSnackBar('', result!, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
