import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/chung_tu_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';
import '../widgets/dialog_create_new_license.dart';
import '../widgets/dialog_edit_license.dart';
import '../widgets/license_item.dart';

class ChungTuScreen extends StatelessWidget {
  const ChungTuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController;
    ChungTuController chungTuController;

    authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    chungTuController = Get.isRegistered<ChungTuController>()
        ? Get.find<ChungTuController>()
        : Get.put(ChungTuController());

    void signOut() async {
      await authController.signOut();
    }

    void createNewLicense() {
      Get.dialog(const DialogCreateNewLicense());
    }

    void onItemClick(
        String atmShipmentId,
        String customerCode,
        String startTime,
        String statusManager,
        String noteFromManage,
        DateTime ngayNop,
        String note,
        int id) {
      Get.dialog(DialogEditLicense(
        atmShipmentId: atmShipmentId,
        customerCode: customerCode,
        startTime: startTime,
        statusManager: statusManager,
        noteFromManage: noteFromManage,
        ngayNop: ngayNop,
        note: note,
        id: id,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleChungTu),
      ),
      drawer: Obx(
        () => AppDrawer(
          fullName: authController.auth.first.fullName,
          position: authController.auth.first.position,
          isBiker: authController.auth.first.isBiker,
          driverId: authController.auth.first.driverId,
          signOut: signOut,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => chungTuController.isLoadingList.value
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: chungTuController.fetchLicenseList,
                  child: ListView.builder(
                    cacheExtent: 10,
                    key: UniqueKey(),
                    itemCount: chungTuController.licenseList.length,
                    itemBuilder: (context, index) => LicenseItem(
                      atmShipmentId:
                          chungTuController.licenseList[index].atmShipmentID,
                      customerCode:
                          chungTuController.licenseList[index].customer,
                      startTime: chungTuController.licenseList[index].startTime,
                      dateOfFiling:
                          chungTuController.licenseList[index].dateOfFiling,
                      statusManager:
                          chungTuController.licenseList[index].statusManager,
                      created: chungTuController.licenseList[index].created,
                      onItemClick: () {
                        chungTuController.textController.text =
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                chungTuController
                                    .licenseList[index].dateOfFiling));
                        onItemClick(
                            chungTuController.licenseList[index].atmShipmentID,
                            chungTuController.licenseList[index].customer,
                            chungTuController.licenseList[index].startTime,
                            chungTuController.licenseList[index].statusManager,
                            chungTuController
                                    .licenseList[index].noteFromManage ??
                                'Không có',
                            DateTime.parse(chungTuController
                                .licenseList[index].dateOfFiling),
                            chungTuController.licenseList[index].reason ?? '',
                            chungTuController.licenseList[index].id);
                      },
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewLicense();
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
