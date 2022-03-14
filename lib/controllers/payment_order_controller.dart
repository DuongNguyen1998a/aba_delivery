import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart'
    as month_year_picker;

import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Models
import '../models/de_nghi_thanh_toan.dart';
import '../models/de_nghi_thanh_toan_detail.dart';
import '../models/detail_order_payment.dart';
import '../models/expense_attachment.dart';
import '../models/payment_order_fee_type.dart';
import '../models/shipment_order_payment.dart';

// Services
import '../services/payment_order_service.dart';

class PaymentOrderController extends GetxController {
  final authController = Get.find<AuthController>();
  var isLoading = false.obs;
  var isLoadingDetail = false.obs;
  var isLoadingImage = false.obs;
  var isLoadingSendPaymentOrder = false.obs;
  var selectedDate = DateTime.now().obs;
  var paymentOrderList = <DeNghiThanhToan>[].obs;
  var paymentOrderDetailList = <DeNghiThanhToanDetail>[].obs;
  var paymentOrderDetailImageList = <ExpenseAttachment>[].obs;
  var imagePickerList = <XFile?>[].obs;
  var totalConLai = 0.obs;
  final ImagePicker imagePicker = ImagePicker();
  var shipmentPaymentOrderList = <ShipmentOrderPayment>[].obs;
  var currentShipmentPaymentOrder = ''.obs;
  final GlobalKey<FormState> paymentOrderForm = GlobalKey();
  final GlobalKey<FormState> updatePaymentForm = GlobalKey();
  var paymentOrderAmount = 0.obs;
  var paymentOrderDescription = ''.obs;
  var feeTypeList = <PaymentOrderFeeType>[].obs;
  var currentFee = ''.obs;
  var numberToll = 1.obs;

  @override
  void onInit() {
    fetchPaymentOrder();
    super.onInit();
  }

  void openMonthYearPicker(BuildContext context) {
    month_year_picker
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
        fetchPaymentOrder();
      }
    });
  }

  int getTotalConLai() {
    if (paymentOrderList.isNotEmpty) {
      totalConLai.value = 0;
      paymentOrderList.map((item) {
        totalConLai += item.amountTotal - item.amount;
      }).toList();
      return totalConLai.value;
    }
    return 0;
  }

  Future<void> fetchPaymentOrder() async {
    try {
      isLoading(true);
      var result = await PaymentOrderService.fetchPaymentOrder(
        selectedDate.value.month.toString(),
        selectedDate.value.year.toString(),
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        paymentOrderList.assignAll(result);
      } else {
        paymentOrderList.assignAll([]);
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

  Future<void> fetchPaymentOrderDetail(String atmShipmentId) async {
    try {
      isLoadingDetail(true);

      var result = await PaymentOrderService.fetchPaymentOrderDetail(
          atmShipmentId, 'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        paymentOrderDetailList.assignAll(result);
      } else {
        paymentOrderDetailList.assignAll([]);
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

  Future<void> fetchPaymentOrderDetailImage(int index) async {
    try {
      isLoadingImage(true);

      var result = await PaymentOrderService.fetchPaymentOrderDetailImage(
          paymentOrderDetailList[index].id,
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        paymentOrderDetailImageList.assignAll(result);
      } else {
        paymentOrderDetailImageList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingImage(false);
    }
  }

  String getOPOrTechnicalStatus(index) {
    if (paymentOrderDetailList.isNotEmpty) {
      if (paymentOrderDetailList[index].advancePaymentType ==
          'PHÍ VÁ VỎ, SỬA XE') {
        return 'Kĩ thuật: ';
      } else {
        return 'OP: ';
      }
    }
    return '';
  }

  void openDialogCamera(int key, int index) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          TextButton(
            onPressed: () {
              key == 1 ? pickImageClick() : pickImageClick1(index);
            },
            child: const Text('Chọn ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              key == 1 ? takePhotoClick() : takePhotoClick1(index);
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

  void pickImageClick() async {
    var getCurrentFee =
        currentFee.value == '' ? feeTypeList[0].iDLoaiPhi : currentFee.value;

    if (getCurrentFee == 'TOLL') {
      Get.defaultDialog(
        radius: 5,
        contentPadding: const EdgeInsets.all(10),
        title: 'Thông báo',
        content: const Text(
          'Phí cầu đường không được chọn ảnh từ thư viện.',
          textAlign: TextAlign.start,
        ),
      );

      Future.delayed(const Duration(milliseconds: 1500), () => Get.back());

      return;
    } else {
      final XFile? mPickImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 768,
      );

      if (mPickImage != null) {
        imagePickerList.add(mPickImage);
      }
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
      imagePickerList.add(mPickImage);
      Get.back();
      addImagePaymentOrderDetail(index, mPickImage);
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
      imagePickerList.add(mTakePhoto);
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
      imagePickerList.add(mTakePhoto);
      Get.back();
      addImagePaymentOrderDetail(index, mTakePhoto);
    }
  }

  Future<void> fetchShipmentOrderPaymentForAddAction() async {
    try {
      var result =
          await PaymentOrderService.fetchShipmentOrderPaymentForAddAction(
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        shipmentPaymentOrderList.assignAll(result);
      } else {
        shipmentPaymentOrderList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  String? setCurrentShipmentPaymentOrder() {
    if (shipmentPaymentOrderList.isNotEmpty) {
      if (currentShipmentPaymentOrder.value == '') {
        currentShipmentPaymentOrder.value =
            shipmentPaymentOrderList[0].atmShipmentID;
        return currentShipmentPaymentOrder.value;
      }
    }
    return currentShipmentPaymentOrder.value;
  }

  int? getSoTienTamUng(String atmShipmentId) {
    if (shipmentPaymentOrderList.isNotEmpty) {
      return shipmentPaymentOrderList
          .where((p0) => p0.atmShipmentID == atmShipmentId)
          .single
          .amount;
    } else {
      return 0;
    }
  }

  int? getSoTienDeNghi(String atmShipmentId) {
    if (shipmentPaymentOrderList.isNotEmpty) {
      return shipmentPaymentOrderList
          .where((p0) => p0.atmShipmentID == atmShipmentId)
          .single
          .amountTotal;
    } else {
      return 0;
    }
  }

  Future<void> fetchPoFeeType() async {
    try {
      var result = await PaymentOrderService.fetchPoFeeType(
          'Bearer ${authController.auth.single.accessToken}');

      if (result != null) {
        feeTypeList.assignAll(result);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPaymentOrder() async {
    try {
      if (imagePickerList.isEmpty && currentFee.value == 'FUEL' ||
          imagePickerList.isEmpty && currentFee.value == 'TOLL' ||
          imagePickerList.isEmpty && currentFee.value == 'INSPECTION' ||
          imagePickerList.isEmpty && currentFee.value == 'TIRE REPAIR FEE') {
        TextContent.getXSnackBar('', TextContent.warningFee, true);
        return;
      } else if (paymentOrderAmount.value < 500) {
        TextContent.getXSnackBar('', TextContent.warningFee2, true);
        return;
      } else {
        if (!paymentOrderForm.currentState!.validate()) {
          return;
        }
        paymentOrderForm.currentState!.save();
        if (paymentOrderDescription.value.isEmpty &&
                currentFee.value == 'TRAFFIC FEE' ||
            paymentOrderDescription.value.isEmpty &&
                currentFee.value == 'OTHERS' ||
            paymentOrderDescription.value.isEmpty &&
                currentFee.value == 'PARKING') {
          TextContent.getXSnackBar('', TextContent.warningFee1, true);
          return;
        }

        List<DetailOrderPayment> mList = [];

        var currentShipment = currentShipmentPaymentOrder.value == ''
            ? shipmentPaymentOrderList[0].atmShipmentID
            : currentShipmentPaymentOrder.value;

        var dataFromCurrentShipment = shipmentPaymentOrderList
            .where((p0) => p0.atmShipmentID == currentShipment)
            .single;

        if (currentFee.value == 'TOLL') {
          for (int i = 0; i < numberToll.value; i++) {
            mList.add(DetailOrderPayment(
                atmShipmentID: currentShipment,
                powerUnit: dataFromCurrentShipment.powerUnitGID!,
                employeeID: authController.auth.single.driverId,
                employeeName: authController.auth.single.fullName,
                department: authController.auth.single.region == 'MN'
                    ? '2001-TRUCKING'
                    : '2002-TRUCKING',
                customer: dataFromCurrentShipment.customerCode!,
                advancePaymentType: currentFee.value,
                description: paymentOrderDescription.value,
                amount: paymentOrderAmount.value,
                city: dataFromCurrentShipment.city!,
                startTime: dataFromCurrentShipment.startTime,
                amountAdjustment: 0,
                sEamount: 0,
                fiNamount: 0,
                id: 0,
                oPamount: 0));
          }
        } else {
          mList.add(DetailOrderPayment(
            atmShipmentID: currentShipment,
            powerUnit: dataFromCurrentShipment.powerUnitGID!,
            employeeID: authController.auth.single.driverId,
            employeeName: authController.auth.single.fullName,
            department: authController.auth.single.region == 'MN'
                ? '2001-TRUCKING'
                : '2002-TRUCKING',
            customer: dataFromCurrentShipment.customerCode!,
            advancePaymentType: currentFee.value,
            description: paymentOrderDescription.value,
            amount: paymentOrderAmount.value,
            city: dataFromCurrentShipment.city!,
            startTime: dataFromCurrentShipment.startTime,
            amountAdjustment: 0,
            sEamount: 0,
            fiNamount: 0,
            id: 0,
            oPamount: 0,
          ));
        }

        isLoadingSendPaymentOrder(true);

        var result = await PaymentOrderService.sendPaymentOrder(
            mList, 'Bearer ${authController.auth.single.accessToken}');

        if (result != null) {
          for (int i = 0; i < result.length; i++) {
            if (imagePickerList.isNotEmpty) {
              for (int i1 = 0; i1 < imagePickerList.length; i1++) {
                await PaymentOrderService.addImagePaymentOrder(
                  'Bearer ${authController.auth.single.accessToken}',
                  result[i].id,
                  result[i].atmShipmentID,
                  result[i].advancePaymentType,
                  imagePickerList[i1]!,
                );
              }
            }
          }
          TextContent.getXSnackBar('', 'Đề nghị thanh toán thành công.', true);
          imagePickerList.assignAll([]);
          fetchPaymentOrder();
          Get.offNamed(AppRoutes.deNghiThanhToanLink);
        } else {
          TextContent.getXSnackBar('', 'Đề nghị thanh toán thất bại.', true);
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoadingSendPaymentOrder(false);
    }
  }

  Future<void> deletePaymentOrder(int index) async {
    try {
      var result = await PaymentOrderService.deletePaymentOrder(
          'Bearer ${authController.auth.single.accessToken}',
          paymentOrderDetailList[index].id);

      if (result == 'Xóa Thành Công!') {
        TextContent.getXSnackBar('', result!, true);
        Get.back();
        paymentOrderDetailImageList.assignAll([]);
        paymentOrderDetailList.removeAt(index);
        paymentOrderDetailList.refresh();
        update();
        if (paymentOrderDetailList.isEmpty) {
          fetchPaymentOrder();
          Get.offAndToNamed(AppRoutes.deNghiThanhToanLink);
          update();
        }
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

  Future<void> editPaymentOrder(int index, BuildContext context) async {
    try {
      updatePaymentForm.currentState!.save();

      var result = await PaymentOrderService.editPaymentOrder(
        paymentOrderDetailList[index].id,
        paymentOrderAmount.value,
        paymentOrderDescription.value,
        paymentOrderDetailList[index].advancePaymentType,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result == 'Cập Nhật Thành Công!') {
        TextContent.getXSnackBar('', result!, true);

        paymentOrderDetailList[index].description =
            paymentOrderDescription.value;
        paymentOrderDetailList[index].amount = paymentOrderAmount.value;
        paymentOrderDetailList.refresh();
      } else {
        TextContent.getXSnackBar('', result!, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      paymentOrderDetailList.refresh();
    }
  }

  Future<void> deleteImagePaymentOrder(int index) async {
    try {
      if (paymentOrderDetailImageList.isEmpty) {
        TextContent.getXSnackBar('', 'Không có hình để xóa.', true);
        return;
      }

      var result = await PaymentOrderService.deleteImagePaymentOrder(
        paymentOrderDetailList[index].id,
        paymentOrderDetailImageList[paymentOrderDetailImageList.length - 1]
            .attachName,
        paymentOrderDetailList[index].advancePaymentType,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result == 'Xóa Thành Công!') {
        TextContent.getXSnackBar('', result!, true);

        paymentOrderDetailImageList
            .removeAt(paymentOrderDetailImageList.length - 1);
        paymentOrderDetailImageList.refresh();
      } else {
        TextContent.getXSnackBar('', result!, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      paymentOrderDetailImageList.refresh();
    }
  }

  Future<void> addImagePaymentOrderDetail(int index, XFile image) async {
    try {
      var result = await PaymentOrderService.addImagePaymentOrderDetail(
          paymentOrderDetailList[index].id,
          paymentOrderDetailList[index].atmShipmentID,
          'Bearer ${authController.auth.single.accessToken}',
          image);

      if (result == 1) {
        TextContent.getXSnackBar('', 'Thêm hình thành công', true);
        fetchPaymentOrderDetailImage(index);
      } else {
        TextContent.getXSnackBar('', 'Thêm hình thất bại', true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
