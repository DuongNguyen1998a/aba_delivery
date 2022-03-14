import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widgets
import '../widgets/text_with_padding5.dart';

class DeNghiThanhToanItem extends StatelessWidget {
  final String atmShipmentId, startTime, customer, advancePaymentType;
  final int amount, amountTotal, amountAdjustment;
  final Function onItemClick;

  const DeNghiThanhToanItem({
    Key? key,
    required this.atmShipmentId,
    required this.startTime,
    required this.customer,
    required this.advancePaymentType,
    required this.amount,
    required this.amountTotal,
    required this.amountAdjustment,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mTextStyle700 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w700,
    );

    const mTextStyle600 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    var formatCurrency = NumberFormat.currency(locale: 'vi_VN');

    return GestureDetector(
      onTap: () {
        onItemClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TextWithPadding5(
                      value: atmShipmentId,
                      textAlign: TextAlign.center,
                      mTextStyle: mTextStyle700,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TextWithPadding5(
                      value: DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(startTime)),
                      textAlign: TextAlign.center,
                      mTextStyle: mTextStyle700,
                    ),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    const TextWithPadding5(
                      value: 'Dự án',
                      textAlign: TextAlign.start,
                      mTextStyle: mTextStyle600,
                    ),
                    TextWithPadding5(
                      value: customer,
                      textAlign: TextAlign.end,
                      mTextStyle: mTextStyle600,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TextWithPadding5(
                      value: 'Tổng phí tạm ứng',
                      textAlign: TextAlign.start,
                      mTextStyle: mTextStyle600,
                    ),
                    TextWithPadding5(
                      value: formatCurrency.format(amountTotal),
                      textAlign: TextAlign.end,
                      mTextStyle: mTextStyle600,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TextWithPadding5(
                      value: 'Tổng phí đã duyệt',
                      textAlign: TextAlign.start,
                      mTextStyle: mTextStyle600,
                    ),
                    TextWithPadding5(
                      value: formatCurrency.format(
                          amountAdjustment > 0 ? amountAdjustment : amount),
                      textAlign: TextAlign.end,
                      mTextStyle: mTextStyle600,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TextWithPadding5(
                      value: 'Còn lại',
                      textAlign: TextAlign.start,
                      mTextStyle: mTextStyle600,
                    ),
                    TextWithPadding5(
                      value: formatCurrency.format(
                        amountAdjustment > 0
                            ? amountTotal - amountAdjustment
                            : amountTotal - amount,
                      ),
                      textAlign: TextAlign.end,
                      mTextStyle: mTextStyle600,
                    ),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TextWithPadding5(
                      value: advancePaymentType,
                      textAlign: TextAlign.start,
                      mTextStyle: mTextStyle600,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
