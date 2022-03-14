import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/chuyenxe_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';
import '../widgets/date_picker.dart';
import '../widgets/shipment_item.dart';

class ChuyenXeScreen extends StatelessWidget {
  const ChuyenXeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController;
    ChuyenXeController chuyenXeController;

    authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    chuyenXeController = Get.isRegistered<ChuyenXeController>()
        ? Get.find<ChuyenXeController>()
        : Get.put(ChuyenXeController());

    final assignedShipments = chuyenXeController.assignedShipments;
    final acceptedShipments = chuyenXeController.acceptedShipments;

    void signOut() async {
      await authController.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleChuyenXeScreen),
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
      body: Column(
        children: [
          const DatePicker(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(
                  child: Obx(
                    () => Badge(
                      animationDuration: const Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.slide,
                      badgeContent: Text(
                        chuyenXeController.acceptedShipments.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          chuyenXeController.key.value = 2;
                          chuyenXeController.fetchShipments(1);
                          chuyenXeController.fetchShipments(2);
                        },
                        child: const Text(TextContent.btnDaNhan),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Obx(
                    () => Badge(
                      animationDuration: const Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.slide,
                      badgeContent: Text(
                        chuyenXeController.assignedShipments.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          chuyenXeController.key.value = 1;
                          chuyenXeController.fetchShipments(1);
                          chuyenXeController.fetchShipments(2);
                        },
                        child: const Text(TextContent.btnDangCho),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Obx(
              () => chuyenXeController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : !chuyenXeController.isLoading.value &&
                          chuyenXeController.key.value == 1 &&
                          chuyenXeController.assignedShipments.isEmpty
                      ? const Text(
                          TextContent.titleNoShipment,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey,
                          ),
                        )
                      : !chuyenXeController.isLoading.value &&
                              chuyenXeController.key.value != 1 &&
                              chuyenXeController.acceptedShipments.isEmpty
                          ? const Text(
                              TextContent.titleNoShipment1,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueGrey,
                              ),
                            )
                          : ListView.builder(
                              key: UniqueKey(),
                              cacheExtent: 10,
                              itemCount: chuyenXeController.key.value == 1
                                  ? chuyenXeController.assignedShipments.length
                                  : chuyenXeController.acceptedShipments.length,
                              itemBuilder: (context, index) => ShipmentItem(
                                atmShipmentId: chuyenXeController.key.value == 1
                                    ? assignedShipments[index].atMSHIPMENTID
                                    : acceptedShipments[index].atMSHIPMENTID,
                                customerCode: chuyenXeController.key.value == 1
                                    ? assignedShipments[index].customerCode ??
                                        ''
                                    : acceptedShipments[index].customerCode ??
                                        '',
                                fromDate: chuyenXeController.key.value == 1
                                    ? assignedShipments[index].starTTIME
                                    : acceptedShipments[index].starTTIME,
                                toDate: chuyenXeController.key.value == 1
                                    ? assignedShipments[index].enDTIME
                                    : acceptedShipments[index].enDTIME,
                                routeNo: chuyenXeController.key.value == 1
                                    ? assignedShipments[index].routeno
                                    : acceptedShipments[index].routeno,
                                mKey: chuyenXeController.key.value,
                              ),
                            ),
            ),
          ),
        ],
      ),
    );
  }
}
