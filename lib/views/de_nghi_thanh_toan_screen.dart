import 'package:flutter/material.dart';
import 'package:get/get.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/payment_order_controller.dart';
import '../widgets/de_nghi_thanh_toan_item.dart';

// Widgets
import '../widgets/lsgh_date_picker.dart';
import '../widgets/payment_order_total_table_row.dart';

class DeNghiThanhToanScreen extends StatelessWidget {
  const DeNghiThanhToanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentOrderController paymentOrderController;
    paymentOrderController = Get.isRegistered<PaymentOrderController>()
        ? Get.find<PaymentOrderController>()
        : Get.put(PaymentOrderController());

    final paymentOrderList = paymentOrderController.paymentOrderList;

    void onItemClick(String atmShipmentId) {
      paymentOrderController.fetchPaymentOrderDetail(atmShipmentId).then((_) {
        Get.toNamed(AppRoutes.deNghiThanhToanDetailLink);
        paymentOrderController.paymentOrderDetailImageList.assignAll([]);
      });
    }

    void createNewPaymentOrder() {
      paymentOrderController.fetchShipmentOrderPaymentForAddAction().then((_) {
        paymentOrderController.fetchPoFeeType().then((_) {
          paymentOrderController.paymentOrderAmount.value = 0;
          Get.toNamed(AppRoutes.deNghiThanhToanAddLink);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.btnDeNghi2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => LsghDatePicker(
                  openDatePicker: () {
                    paymentOrderController.openMonthYearPicker(context);
                  },
                  dateTimeValue: paymentOrderController.selectedDate.value,
                ),
              ),
              const PaymentOrderTotalTableRow(),
              Expanded(
                child: Obx(
                  () => paymentOrderController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: paymentOrderController.fetchPaymentOrder,
                          child: ListView.builder(
                            key: UniqueKey(),
                            cacheExtent: 10,
                            itemCount: paymentOrderList.length,
                            itemBuilder: (context, index) =>
                                DeNghiThanhToanItem(
                              atmShipmentId: paymentOrderList[index].atmShipmentID,
                              startTime: paymentOrderList[index].startTime,
                              customer: paymentOrderList[index].customer,
                              advancePaymentType: paymentOrderList[index].advancePaymentType,
                              amount: paymentOrderList[index].amount,
                              amountTotal: paymentOrderList[index].amountTotal,
                              amountAdjustment: paymentOrderList[index].amountAdjustment,
                              onItemClick: () {
                                onItemClick(paymentOrderList[index].atmShipmentID);
                              },
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewPaymentOrder();
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
