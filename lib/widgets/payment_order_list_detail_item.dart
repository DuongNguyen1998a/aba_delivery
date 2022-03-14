import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

class PaymentOrderListDetailItem extends StatelessWidget {
  final double widthOfScreen;
  final Function onItemClick,
      onShowImageClick,
      onEditClick,
      onDeleteClick,
      onDeleteImageClick,
      onAddImageClick;
  final String advPaymentType,
      udWho,
      opOrTechStatus,
      finApproved,
      seApproved,
      description,
      finRemark,
      seRemark,
      opRemark,
      invoiceDate;
  final int amount, amountAdjustment, opAmount, seAmount, finAmount;

  const PaymentOrderListDetailItem(
      {Key? key,
      required this.widthOfScreen,
      required this.onItemClick,
      required this.onShowImageClick,
      required this.advPaymentType,
      required this.amount,
      required this.amountAdjustment,
      required this.udWho,
      required this.opOrTechStatus,
      required this.finApproved,
      required this.seApproved,
      required this.description,
      required this.finAmount,
      required this.seAmount,
      required this.opAmount,
      required this.finRemark,
      required this.opRemark,
      required this.seRemark,
      required this.invoiceDate,
      required this.onDeleteClick,
      required this.onEditClick,
      required this.onDeleteImageClick,
      required this.onAddImageClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatCurrency = NumberFormat.currency(locale: 'vi_VN');
    const mTextStyle700 = TextStyle(
      color: Colors.blueGrey,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    const mTextStyle600 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );
    const mTextStyle500 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    return GestureDetector(
      onTap: () {
        onItemClick();
        // poController.fetchPaymentOrderDetailImage(
        //     poController.paymentOrderDetailList[index].id);
      },
      child: SizedBox(
        width: widthOfScreen,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      advPaymentType,
                      style: mTextStyle700,
                    ),
                    TextButton(
                      onPressed: () {
                        onShowImageClick();
                        // paymentOrderController.fetchPaymentOrderDetailImage(
                        //     paymentOrderController
                        //         .paymentOrderDetailList[index].id);
                      },
                      child: const Text(TextContent.btnShowImage),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Số tiền đề nghị: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      formatCurrency.format(amount),
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Số tiền đã duyệt: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      formatCurrency.format(amountAdjustment),
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Text(udWho),
                Wrap(
                  children: [
                    Text(
                      opOrTechStatus,
                      style: mTextStyle600,
                    ),
                    Text(
                      finApproved,
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Trưởng BP: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      seApproved,
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'SE: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      seApproved,
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'FIN: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      finApproved,
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Mô tả: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      description,
                      style: mTextStyle500,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Số tiền OP điều chỉnh: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      formatCurrency.format(opAmount),
                      style: mTextStyle500,
                    )
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Số tiền SE điều chỉnh: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      formatCurrency.format(seAmount),
                      style: mTextStyle500,
                    )
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Số tiền FIN điều chỉnh: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      formatCurrency.format(finAmount),
                      style: mTextStyle500,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: [
                    const Text(
                      'Lí do FIN: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      finRemark,
                      style: mTextStyle500,
                    )
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Lí do SE: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      seRemark,
                      style: mTextStyle500,
                    )
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      'Lí do OP: ',
                      style: mTextStyle600,
                    ),
                    Text(
                      opRemark,
                      style: mTextStyle500,
                    )
                  ],
                ),
                Text(
                  DateFormat('dd-MM-yyyy HH:mm').format(
                    DateTime.parse(invoiceDate),
                  ),
                  textAlign: TextAlign.end,
                  style: mTextStyle600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onEditClick();
                          // editPaymentOrder(
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index].id,
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index].amount,
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index].description,
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index]
                          //         .advancePaymentType,
                          //     index);
                        },
                        child: const Text('Sửa'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onDeleteClick();
                          // deletePaymentOrder(
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index].id,
                          //     paymentOrderController
                          //         .paymentOrderDetailList[index].atmShipmentID);
                        },
                        child: const Text('Xóa'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onDeleteImageClick();
                        },
                        child: const Text('Xóa ảnh'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onAddImageClick();
                        },
                        child: const Text('Thêm ảnh'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
