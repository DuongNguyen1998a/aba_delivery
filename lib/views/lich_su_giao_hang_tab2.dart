import 'package:flutter/material.dart';
import 'package:get/get.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/lich_su_giao_hang_controller.dart';
import '../widgets/lich_su_giao_hang_tab2_item.dart';

// Widgets
import '../widgets/lsgh_date_picker.dart';

class LichSuGiaoHangTab2 extends StatelessWidget {
  const LichSuGiaoHangTab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LichSuGiaoHangController lsghController;
    lsghController = Get.isRegistered<LichSuGiaoHangController>()
        ? Get.find<LichSuGiaoHangController>()
        : Get.put(LichSuGiaoHangController());

    const mTextStyle = TextStyle(
      color: Colors.orangeAccent,
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => LsghDatePicker(
            openDatePicker: () {
              lsghController.openMonthYearPicker1(context);
            },
            dateTimeValue: lsghController.selectedDate1.value,
          ),
        ),
        Expanded(
          child: Obx(
            () => lsghController.isLoadingDelivery.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await lsghController.fetchHistoryDelivery();
                    },
                    child: ListView.builder(
                      key: UniqueKey(),
                      cacheExtent: 10,
                      itemCount: lsghController.historyDeliveryList.length,
                      itemBuilder: (context, index) => LichSuGiaoHangTab2Item(
                        atmShipmentId: lsghController
                            .historyDeliveryList[index].atmShipmentID,
                        customerCode: lsghController
                            .historyDeliveryList[index].customerCode,
                        startTime:
                            lsghController.historyDeliveryList[index].startTime,
                        deliveryTime: lsghController
                            .historyDeliveryList[index].deliveryTime,
                        isRightTime: lsghController.compareDateTime(index),
                        onItemClick: () {
                          lsghController
                              .fetchHistoryDeliveryDetail(lsghController
                                  .historyDeliveryList[index].atmShipmentID)
                              .then(
                                (_) => Get.toNamed(
                                    AppRoutes.historyDeliveryDetailLink,
                                    arguments: [
                                      {
                                        'atmShipmentId': lsghController
                                            .historyDeliveryList[index]
                                            .atmShipmentID
                                      }
                                    ]),
                              );
                        },
                      ),
                    ),
                  ),
          ),
        ),
        Card(
          elevation: 5,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Text(
                '${TextContent.total} : ${lsghController.historyDeliveryList.length}',
                textAlign: TextAlign.center,
                style: mTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
