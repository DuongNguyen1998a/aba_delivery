import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/constants/text_content.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/payment_order_controller.dart';

class PaymentOrderDialogEdit extends StatelessWidget {
  final int index;

  const PaymentOrderDialogEdit({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poController = Get.find<PaymentOrderController>();

    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: Form(
        key: poController.updatePaymentForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Số tiền thanh toán',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    initialValue: poController
                        .paymentOrderDetailList[index].amount
                        .toString(),
                    onSaved: (val) {
                      poController.paymentOrderAmount.value = int.parse(val!);
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ghi chú',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    initialValue:
                        poController.paymentOrderDetailList[index].description,
                    onSaved: (val) {
                      poController.paymentOrderDescription.value = val!;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(TextContent.btnClose),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            poController.editPaymentOrder(index, context);
                            Get.back();
                          },
                          child: const Text(TextContent.btnConfirm),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
