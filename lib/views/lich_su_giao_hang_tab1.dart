import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/lich_su_giao_hang_controller.dart';
import '../widgets/lich_su_giao_hang_tab1_item.dart';

// Widgets
import '../widgets/lsgh_date_picker.dart';

class LichSuGiaoHangTab1 extends StatelessWidget {
  const LichSuGiaoHangTab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LichSuGiaoHangController lsghController;
    lsghController = Get.isRegistered<LichSuGiaoHangController>()
        ? Get.find<LichSuGiaoHangController>()
        : Get.put(LichSuGiaoHangController());

    final formatCurrency = NumberFormat.currency(locale: 'vi_VN');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 5,
        ),
        Obx(
          () => LsghDatePicker(
            openDatePicker: () {
              lsghController.openMonthYearPicker(context);
            },
            dateTimeValue: lsghController.selectedDate.value,
          ),
        ),
        Expanded(
          child: Obx(
            () => lsghController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async {
                      await lsghController.fetchHistorySalary(
                        lsghController.selectedDate.value.year,
                        lsghController.selectedDate.value.month,
                      );
                    },
                    child: ListView.builder(
                      key: UniqueKey(),
                      cacheExtent: 10,
                      itemCount: lsghController.historyList.length,
                      itemBuilder: (context, index) => LichSuGiaoHangTab1Item(
                        atmShipmentId:
                            lsghController.historyList[index].shipmenTID,
                        transDate: lsghController.historyList[index].tranSDATE,
                        status: lsghController.historyList[index].status,
                        salary: lsghController.historyList[index].salary,
                        onItemClick: () {
                          lsghController
                              .fetchHistorySalaryDetail(
                                  lsghController.historyList[index].shipmenTID)
                              .then(
                                (value) => Get.toNamed(
                                  AppRoutes.lsghDetailLink,
                                  arguments: [
                                    {
                                      'atmShipmentId': lsghController
                                          .historyList[index].shipmenTID
                                    }
                                  ],
                                ),
                              );
                        },
                      ),
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
                '${TextContent.tamTinh}${formatCurrency.format(lsghController.totalAmount.value)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
