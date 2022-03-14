import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Widgets
import '../widgets/text_with_padding5.dart';

// Controllers
import '../controllers/payment_order_controller.dart';

// Text Content
import '../constants/text_content.dart';

class PaymentOrderTotalTableRow extends StatelessWidget {
  const PaymentOrderTotalTableRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentOrderController = Get.find<PaymentOrderController>();
    var formatCurrency = NumberFormat.currency(locale: 'vi_VN');
    const mTextStyle600 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              Obx(
                () => TextWithPadding5(
                  value:
                      '${TextContent.totalRemain}${formatCurrency.format(paymentOrderController.getTotalConLai())}',
                  textAlign: TextAlign.center,
                  mTextStyle: mTextStyle600,
                ),
              ),
              Obx(
                () => TextWithPadding5(
                  value:
                      '${TextContent.totalShipment}${paymentOrderController.paymentOrderList.length}',
                  textAlign: TextAlign.center,
                  mTextStyle: mTextStyle600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
