import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/widgets/text_with_padding5.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/gas_controller.dart';

// Widgets
import '../widgets/gas_date_picker.dart';

class GasTicketScreen extends StatelessWidget {
  const GasTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GasController gasController = Get.find<GasController>();
    // gasController = Get.isRegistered<GasController>()
    //     ? Get.find<GasController>()
    //     : Get.put(GasController());

    const mTextStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phiếu của tôi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => GasDatePicker(
                openDatePicker: () {
                  gasController.openDatePicker(context);
                },
                dateTimeValue: gasController.selectedDate.value,
              ),
            ),
            Expanded(
              child: Obx(
                () => gasController.gasTicketHistoryList.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        key: UniqueKey(),
                        cacheExtent: 10,
                        itemCount: gasController.gasTicketHistoryList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Số phiếu',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                          .gasTicketHistoryList[index]
                                          .ticketId ??
                                      '',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Số xe',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                          .gasTicketHistoryList[index]
                                          .powerUnit ??
                                      '',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Tên cây dầu',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                          .gasTicketHistoryList[index]
                                          .gasStationName ??
                                      '',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'ODO trước (Km)',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                      .gasTicketHistoryList[index].odoPrevious
                                      .toString(),
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'ODO hiện tại (Km)',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                      .gasTicketHistoryList[index].odoCurrent
                                      .toString(),
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Số lit thực tế',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                      .gasTicketHistoryList[index].actualQty
                                      .toString(),
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'QR số lít thực tế',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                      .gasTicketHistoryList[index]
                                      .qrCodeActualQty
                                      .toString(),
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Thực tế L/100 Km',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController.getLit100Km(index),
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                              TableRow(children: [
                                const TextWithPadding5(
                                  value: 'Trạng thái',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                TextWithPadding5(
                                  value: gasController
                                              .gasTicketHistoryList[index]
                                              .status ==
                                          1
                                      ? 'Đã duyệt'
                                      : gasController
                                                  .gasTicketHistoryList[index]
                                                  .status ==
                                              2
                                          ? 'Từ chối duyệt'
                                          : 'Chưa duyệt',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
