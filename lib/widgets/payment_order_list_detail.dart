import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/payment_order_controller.dart';

// Widgets
import '../widgets/payment_order_list_detail_item.dart';
import '../widgets/payment_order_dialog_edit.dart';

// Text Content
import '../constants/text_content.dart';

class PaymentOrderListDetail extends StatelessWidget {
  const PaymentOrderListDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.of(context).size.width;
    PaymentOrderController poController;
    poController = Get.isRegistered<PaymentOrderController>()
        ? Get.find<PaymentOrderController>()
        : Get.put(PaymentOrderController());
    var paymentOrderDetailList = poController.paymentOrderDetailList;

    void onItemClick(int index) {
      poController.fetchPaymentOrderDetailImage(index);
    }

    void onShowImageClick(int index) {
      poController.fetchPaymentOrderDetailImage(index);
    }

    void onDeleteClick(int index) {
      Get.defaultDialog(
        title: '',
        middleText: 'Bạn có chắc muốn xóa phí này ?',
        textCancel: 'Hủy',
        textConfirm: 'Đồng ý',
        onConfirm: () {
          Get.back();
          poController.deletePaymentOrder(index);
        }
      );
    }

    void onEditClick(int index) {
      Get.dialog(PaymentOrderDialogEdit(index: index));
    }

    void onDeleteImageClick(int index) {
      Get.defaultDialog(
          title: '',
          middleText: 'Bạn có chắc muốn xóa ảnh\n(xóa hình cuối cùng) ?',
          textCancel: 'Hủy',
          textConfirm: 'Đồng ý',
          onConfirm: () {
            Get.back();
            poController.deleteImagePaymentOrder(index);
          }
      );
    }

    void onAddImageClick(int index) {
      poController.openDialogCamera(2, index);

    }

    return Expanded(
      child: GetBuilder<PaymentOrderController>(
        init: PaymentOrderController(),
        builder: (data) => poController.isLoadingDetail.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                key: UniqueKey(),
                cacheExtent: 10,
                itemCount: paymentOrderDetailList.length,
                itemBuilder: (context, index) => Obx(
                  () => PaymentOrderListDetailItem(
                    widthOfScreen: widthOfScreen,
                    onItemClick: () {
                      onItemClick(index);
                    },
                    onShowImageClick: () {
                      onShowImageClick(index);
                    },
                    advPaymentType: paymentOrderDetailList[index].advancePaymentType,
                    amount: paymentOrderDetailList[index].amount,
                    amountAdjustment: paymentOrderDetailList[index].amountAdjustment,
                    udWho: paymentOrderDetailList[index].udWho,
                    opOrTechStatus: poController.getOPOrTechnicalStatus(index),
                    finApproved: paymentOrderDetailList[index].finApproved,
                    seApproved: paymentOrderDetailList[index].seApproved,
                    description: paymentOrderDetailList[index].description,
                    finAmount: paymentOrderDetailList[index].fiNamount,
                    seAmount: paymentOrderDetailList[index].sEamount,
                    opAmount: paymentOrderDetailList[index].oPamount,
                    finRemark: paymentOrderDetailList[index].finRemark ?? TextContent.textNone,
                    opRemark: paymentOrderDetailList[index].opRemark ?? TextContent.textNone,
                    seRemark: paymentOrderDetailList[index].seRemark ?? TextContent.textNone,
                    invoiceDate: paymentOrderDetailList[index].invoiceDate,
                    onDeleteClick: () {
                      onDeleteClick(index);
                    },
                    onEditClick: () {
                      onEditClick(index);
                    },
                    onDeleteImageClick: () {
                      onDeleteImageClick(index);
                    },
                    onAddImageClick: () {
                      onAddImageClick(index);
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
