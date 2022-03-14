import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Controllers
import '../controllers/giao_bu_controller.dart';

// Widgets
import '../widgets/text_with_padding5.dart';
import 'dialog_update_quantity_giao_bu.dart';

class DialogGiaoBu extends StatelessWidget {
  final String storeCode, addressLine, atmShipmentId, customer;

  const DialogGiaoBu({
    Key? key,
    required this.storeCode,
    required this.addressLine,
    required this.atmShipmentId,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final giaoBuController = Get.find<GiaoBuController>();

    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );

    const mTextStyle1 = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    void updateQuantityGiaoBu(
        String itemName, double soBich, double actualReceived, String rowId) {
      Get.dialog(DialogUpdateQuantityGiaoBu(
        itemName: itemName,
        soBich: soBich,
        actualReceived: actualReceived,
        rowId: rowId,
      ));
    }

    return Container(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithPadding5(
                  value:
                      'Thời gian: ${DateFormat('dd / MM / yyyy').format(DateTime.now())}',
                  textAlign: TextAlign.start,
                  mTextStyle: mTextStyle,
                ),
                TextWithPadding5(
                  value: 'Mã cửa hàng: $storeCode',
                  textAlign: TextAlign.start,
                  mTextStyle: mTextStyle,
                ),
                TextWithPadding5(
                  value: 'Địa chỉ: $addressLine',
                  textAlign: TextAlign.start,
                  mTextStyle: mTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => giaoBuController.giaoBuItemList.isEmpty
                  ? const Center(child: SizedBox())
                  : ListView.builder(
                      key: UniqueKey(),
                      cacheExtent: 10,
                      itemCount: giaoBuController.giaoBuItemList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          updateQuantityGiaoBu(
                            giaoBuController.giaoBuItemList[index].itemName ??
                                '',
                            giaoBuController.giaoBuItemList[index].soBich ?? 0,
                            giaoBuController
                                    .giaoBuItemList[index].actualReceived ??
                                0,
                            giaoBuController.giaoBuItemList[index].rowId.toString(),
                          );
                        },
                        child: Card(
                          elevation: 1,
                          margin: const EdgeInsets.all(5),
                          color: Colors.white54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextWithPadding5(
                                value: giaoBuController
                                        .giaoBuItemList[index].itemName ??
                                    '',
                                textAlign: TextAlign.center,
                                mTextStyle: mTextStyle1,
                              ),
                              TextWithPadding5(
                                value:
                                    ' - SL phải giao CH: ${giaoBuController.giaoBuItemList[index].soBich!.toInt()}',
                                textAlign: TextAlign.start,
                                mTextStyle: mTextStyle1,
                              ),
                              TextWithPadding5(
                                value:
                                    ' - SL giao CH: ${giaoBuController.giaoBuItemList[index].actualReceived!.toInt()}',
                                textAlign: TextAlign.start,
                                mTextStyle: mTextStyle1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Đóng'),
            ),
          ),
        ],
      ),
    );
  }
}
