import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widgets
import 'text_with_padding5.dart';

class DeNghiTamUngItem extends StatelessWidget {
  final String advancePaymentType,
      atmShipmentID,
      manager,
      opRemark,
      finApproved,
      finRemark,
      createDate;
  final int amount;
  final Function onItemClick;

  const DeNghiTamUngItem({
    Key? key,
    required this.advancePaymentType,
    required this.atmShipmentID,
    required this.amount,
    required this.manager,
    required this.opRemark,
    required this.finApproved,
    required this.finRemark,
    required this.createDate,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatCurrency = NumberFormat.currency(locale: 'vi_VN');
    const mTextStyle500 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {
        onItemClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TextWithPadding5(
                      value: advancePaymentType,
                      textAlign: TextAlign.center,
                      mTextStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TextWithPadding5(
                      value: atmShipmentID,
                      textAlign: TextAlign.center,
                      mTextStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Tiền tạm ứng',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: formatCurrency.format(amount),
                    textAlign: TextAlign.end,
                    mTextStyle: mTextStyle500,
                  ),
                ]),
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Tưởng BP',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: manager,
                    textAlign: TextAlign.end,
                    mTextStyle: mTextStyle500,
                  ),
                ]),
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Lí do',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: opRemark,
                    textAlign: TextAlign.end,
                    mTextStyle: mTextStyle500,
                  ),
                ]),
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Kế toán',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: finApproved,
                    textAlign: TextAlign.end,
                    mTextStyle: mTextStyle500,
                  ),
                ]),
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Lí do',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: finRemark,
                    textAlign: TextAlign.end,
                    mTextStyle: mTextStyle500,
                  ),
                ]),
                TableRow(children: [
                  const TextWithPadding5(
                    value: 'Ngày tạm ứng',
                    textAlign: TextAlign.start,
                    mTextStyle: mTextStyle500,
                  ),
                  TextWithPadding5(
                    value: DateFormat('dd-MM-yyyy HH:mm').format(
                      DateTime.parse(createDate),
                    ),
                    mTextStyle: mTextStyle500,
                    textAlign: TextAlign.end,
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
