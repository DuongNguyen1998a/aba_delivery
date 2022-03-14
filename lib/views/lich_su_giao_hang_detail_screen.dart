import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/lich_su_giao_hang_controller.dart';

class LichSuGiaoHangDetailScreen extends StatelessWidget {
  const LichSuGiaoHangDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LichSuGiaoHangController lsghController;
    lsghController = Get.isRegistered<LichSuGiaoHangController>()
        ? Get.find<LichSuGiaoHangController>()
        : Get.put(LichSuGiaoHangController());

    final formatCurrency = NumberFormat.currency(locale: 'vi_VN');
    var arguments = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Lương chi tiết'),
            const SizedBox(
              height: 2,
            ),
            Text(arguments[0]['atmShipmentId']),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Table(
                border: TableBorder.all(),
                children: const [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Loại lương',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Trị giá',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Mô tả',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => lsghController.isLoadingDetail.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          key: UniqueKey(),
                          cacheExtent: 10,
                          itemCount: lsghController.historyDetailList.length,
                          itemBuilder: (context, index) => Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    lsghController
                                        .historyDetailList[index].salarYELEMENT,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    formatCurrency.format(lsghController
                                        .historyDetailList[index].salarYAMOUNT),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    lsghController
                                        .historyDetailList[index].description,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                ),
              ),
              Card(
                elevation: 8,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Text(
                      '${TextContent.tamTinh}${formatCurrency.format(lsghController.totalAmountDetail.value)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
