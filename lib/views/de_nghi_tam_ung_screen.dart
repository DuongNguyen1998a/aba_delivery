import 'package:flutter/material.dart';
import 'package:get/get.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/phi_controller.dart';
import '../widgets/de_nghi_tam_ung_item.dart';

// Widgets
import '../widgets/lsgh_date_picker.dart';

class DeNghiTamUngScreen extends StatelessWidget {
  const DeNghiTamUngScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhiController phiController;
    phiController = Get.isRegistered<PhiController>()
        ? Get.find<PhiController>()
        : Get.put(PhiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.btnDeNghi1),
        leading: BackButton(onPressed: () {
          Get.toNamed(AppRoutes.phiLink);
        },),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => LsghDatePicker(
                  openDatePicker: () {
                    phiController.openMonthYearPicker(context);
                  },
                  dateTimeValue: phiController.selectedDate.value,
                ),
              ),
              Expanded(
                child: Obx(
                  () => phiController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: phiController.fetchDeNghiTamUng,
                          child: ListView.builder(
                            key: UniqueKey(),
                            cacheExtent: 10,
                            itemCount: phiController.tamUngList.length,
                            itemBuilder: (context, index) => DeNghiTamUngItem(
                              advancePaymentType: phiController
                                  .tamUngList[index].advancePaymentType,
                              atmShipmentID: phiController
                                      .tamUngList[index].atmShipmentID ??
                                  '',
                              amount: phiController.tamUngList[index].amount,
                              manager: phiController.tamUngList[index].manager,
                              opRemark:
                                  phiController.tamUngList[index].opRemark,
                              finApproved:
                                  phiController.tamUngList[index].finApproved,
                              finRemark:
                                  phiController.tamUngList[index].finRemark,
                              createDate:
                                  phiController.tamUngList[index].createDate,
                              onItemClick: () {
                                phiController.expenseImageList.assignAll([]);
                                Get.toNamed(
                                  AppRoutes.deNghiTamUngDetailLink,
                                  arguments: [
                                    {'index': index}
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          phiController.fetchFeeType().then((_) {
            phiController.fetchShipmentAdvPayment().then((_) {
              phiController.imageTamUngList.assignAll([]);
              Get.toNamed(AppRoutes.deNghiTamUngAddLink);
            });
          });
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
