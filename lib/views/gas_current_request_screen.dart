import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Controllers
import '../controllers/gas_controller.dart';
import '../controllers/location_controller.dart';

// Widgets
import '../widgets/text_with_padding5.dart';
import '../widgets/dialog_gas_station_list.dart';

class GasCurrentRequestScreen extends StatelessWidget {
  const GasCurrentRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mTextStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    GasController gasController = Get.find<GasController>();

    var formatCurrency = NumberFormat.currency(locale: "vi_VN");

    void openDialogGasStationList() {
      Get.dialog(const DialogGasStationList());
    }

    void openDialogScanQrCode(String ticketId) {
      Get.dialog(DialogScanQrCode(
        ticketId: ticketId,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          onPressed: () {
            Get.back();
            gasController.fetchGasLimit();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Form(
          key: gasController.formKeys[1],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: RefreshIndicator(
            onRefresh: gasController.fetchGasTicket,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'S??? phi???u',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: gasController.gasTicketList.isNotEmpty
                                ? gasController.gasTicketList[0].ticketId ?? ''
                                : '',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'S??? xe',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: gasController.gasTicketList.isNotEmpty
                                ? gasController.gasTicketList[0].powerUnit ?? ''
                                : '',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'T??n c??y d???u',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Obx(
                          () => GestureDetector(
                            onTap: gasController.gasTicketList.isNotEmpty
                                ? gasController.gasTicketList[0].status == 1
                                    ? () {
                                        openDialogGasStationList();
                                      }
                                    : null
                                : null,
                            child: Obx(
                              () => TextWithPadding5(
                                  value: gasController.gasTicketList.isNotEmpty
                                      ? gasController.gasTicketList[0]
                                              .gasStationName ??
                                          ''
                                      : '',
                                  mTextStyle: mTextStyle,
                                  textAlign: TextAlign.left),
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'ODO tr?????c (Km)',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: gasController.gasTicketList.isNotEmpty
                                ? gasController.gasTicketList[0].odoPrevious
                                    .toString()
                                : '0',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'ODO hi???n t???i (Km)',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  enabled: gasController
                                          .gasTicketList.isNotEmpty
                                      ? gasController.gasTicketList[0].status ==
                                              1
                                          ? true
                                          : false
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: 'Nh???p gi?? tr???'),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'ODO hi???n t???i kh??ng ???????c b??? tr???ng';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    gasController.odoCurrent.value =
                                        int.parse(val!);
                                  },
                                ),
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                onPressed: gasController
                                        .gasTicketList.isNotEmpty
                                    ? gasController.gasTicketList[0].status == 1
                                        ? () {
                                            gasController.takeImage(1);
                                          }
                                        : null
                                    : null,
                                icon: const Icon(Icons.camera),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'H???n m???c',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: gasController.limit.toString(),
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'S??? lit th???c t???',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Nh???p gi?? tr???'),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'S??? l??t th???c t??? kh??ng ???????c b??? tr???ng';
                                    } else if (double.parse(val) > 100) {
                                      return 'Kh??ng ???????c v?????t h???n m???c';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    gasController.actualLit.value =
                                        double.parse(val!);
                                  },
                                  onChanged: (val) {
                                    if (val.isEmpty) {
                                      gasController.actualLit.value = 0.0;
                                    } else {
                                      gasController.actualLit.value =
                                          double.parse(val);
                                    }
                                  },
                                  enabled: gasController
                                          .gasTicketList.isNotEmpty
                                      ? gasController.gasTicketList[0].status ==
                                              1
                                          ? true
                                          : false
                                      : null,
                                ),
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                onPressed: gasController
                                        .gasTicketList.isNotEmpty
                                    ? gasController.gasTicketList[0].status == 1
                                        ? () {
                                            gasController.takeImage(2);
                                          }
                                        : null
                                    : null,
                                icon: const Icon(Icons.camera),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: '????n gi??',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Nh???p gi?? tr???'),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return '????n gi?? kh??ng ???????c b??? tr???ng';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    if (val.isEmpty) {
                                      gasController.unitPrice.value = 0;
                                    } else {
                                      gasController.unitPrice.value =
                                          int.parse(val);
                                    }
                                  },
                                  onSaved: (val) {
                                    gasController.unitPrice.value =
                                        int.parse(val!);
                                  },
                                  enabled: gasController
                                          .gasTicketList.isNotEmpty
                                      ? gasController.gasTicketList[0].status ==
                                              1
                                          ? true
                                          : false
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'Th??nh ti???n',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Obx(
                          () => TextWithPadding5(
                              value: formatCurrency
                                  .format(gasController.unitPrice.value *
                                      gasController.actualLit.value)
                                  .toString(),
                              mTextStyle: mTextStyle,
                              textAlign: TextAlign.left),
                        ),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'Theo ?????nh m???c',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: gasController.gasTicketList.isNotEmpty
                                ? gasController.gasTicketList[0].norm.toString()
                                : '0',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      const TableRow(children: [
                        TextWithPadding5(
                            value: 'Th???c t??? L/100 Km',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        TextWithPadding5(
                            value: '0',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                      ]),
                      TableRow(children: [
                        const TextWithPadding5(
                            value: 'Tr???ng th??i',
                            mTextStyle: mTextStyle,
                            textAlign: TextAlign.left),
                        Obx(
                          () => TextWithPadding5(
                              value: gasController.gasTicketList.isNotEmpty
                                  ? gasController.gasTicketList[0].status == 1
                                      ? '???? duy???t'
                                      : gasController.gasTicketList[0].status ==
                                              2
                                          ? 'T??? ch???i duy???t'
                                          : 'Ch??a duy???t'
                                  : '',
                              mTextStyle: mTextStyle,
                              textAlign: TextAlign.left),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            gasController.updateGasRequest(context);
                          },
                          child: const Text('X??c nh???n'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (gasController.gasTicketList.isEmpty) {
                              return;
                            } else {
                              openDialogScanQrCode(
                                  gasController.gasTicketList[0].ticketId ??
                                      '');
                            }
                          },
                          child: const Text('Qu??t QR code'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => gasController.imagePickerList.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 300,
                            child: ListView.builder(
                              key: UniqueKey(),
                              cacheExtent: 10,
                              itemCount: gasController.imagePickerList.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(gasController
                                      .imagePickerList[index]!.path),
                                  height: 140,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogScanQrCode extends StatelessWidget {
  final String ticketId;

  const DialogScanQrCode({Key? key, required this.ticketId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Center(
        child: QrImage(
          data: 'https://customer.aba.com.vn/Gas?ticketId=$ticketId',
          version: QrVersions.auto,
          size: 250.0,
        ),
      ),
    );
  }
}
