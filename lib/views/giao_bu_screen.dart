import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/widgets/dialog_giao_bu.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/giao_bu_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';
import '../widgets/gas_date_picker.dart';

class GiaoBuScreen extends StatelessWidget {
  const GiaoBuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final giaoBuController = Get.find<GiaoBuController>();

    const mTextStyle700 = TextStyle(
        fontWeight: FontWeight.w700, color: Colors.blueGrey, fontSize: 15);

    const mTextStyle600 = TextStyle(
        fontWeight: FontWeight.w600, color: Colors.blueGrey, fontSize: 13);

    void signOut() async {
      await authController.signOut();
    }

    void openDialogItemClick(String storeCode, String address,
        String atmShipmentId, String customer) {
      giaoBuController
          .fetchItemDetailGiaoBu(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        storeCode,
        customer,
        atmShipmentId,
      )
          .then((_) {
        Get.dialog(
          DialogGiaoBu(
              addressLine: address,
              storeCode: storeCode,
              atmShipmentId: atmShipmentId,
              customer: customer),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleGiaoBu),
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => GasDatePicker(
                  openDatePicker: () {
                    giaoBuController.openDatePicker(context);
                  },
                  dateTimeValue: giaoBuController.selectedDate.value,
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: giaoBuController.selectedDropDown.value,
                    onChanged: (newVal) {
                      giaoBuController.selectedDropDown.value =
                          newVal as String;
                      giaoBuController.fetchGiaoBuList(newVal);
                    },
                    items: giaoBuController.bikerCustomerList.map((item) {
                      return DropdownMenuItem(
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.orangeAccent,
                                width: 1.2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.customerName ?? ''),
                            ),
                          ),
                        ),
                        value: item.customerName ?? '',
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => giaoBuController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          key: UniqueKey(),
                          cacheExtent: 10,
                          itemCount: giaoBuController.giaoBuList.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              openDialogItemClick(
                                  giaoBuController
                                          .giaoBuList[index].storeCode ??
                                      '',
                                  giaoBuController.giaoBuList[index].address ??
                                      '',
                                  giaoBuController
                                          .giaoBuList[index].atmShipmentID ??
                                      '',
                                  giaoBuController
                                          .giaoBuList[index].khachHang ??
                                      '');
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.orangeAccent,
                                  width: 1.2,
                                ),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      giaoBuController
                                              .giaoBuList[index].storeCode ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: mTextStyle700,
                                    ),
                                    Text(
                                      giaoBuController
                                              .giaoBuList[index].address ??
                                          '',
                                      style: mTextStyle600,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
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
