import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';
import '../widgets/dialog_hoan_thanh_chuyen.dart';
import '../widgets/dialog_hoan_thanh_chuyen_biker.dart';
import '../widgets/home_header.dart';
import '../widgets/shipment_stop_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    HomeController homeController = Get.put(HomeController());

    // authController = Get.isRegistered<AuthController>()
    //     ? Get.find<AuthController>()
    //     : Get.put(AuthController());
    // homeController = Get.isRegistered<HomeController>()
    //     ? Get.find<HomeController>()
    //     : Get.put(HomeController());

    void signOut() async {
      await authController.signOut();
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(TextContent.titleHomeScreen),
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
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  './assets/images/img.png',
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<HomeController>(
                init: HomeController(),
                builder: (cont) => homeController.isLoading.value
                    ? const SizedBox()
                    : !homeController.isLoading.value &&
                            homeController.currentShipment.isEmpty
                        ? const SizedBox()
                        : !homeController.isLoading.value &&
                                homeController.currentShipment[0].roiKho &&
                                homeController.currentShipmentStops.isEmpty
                            ? const SizedBox()
                            : HomeHeader(
                                atmShipmentId: homeController
                                    .currentShipment[0].atMSHIPMENTID,
                                customerCode: homeController
                                        .currentShipment[0].customerCode ??
                                    '',
                                startDate:
                                    homeController.currentShipment[0].starTTIME,
                                endDate:
                                    homeController.currentShipment[0].enDTIME,
                                comeWhse:
                                    homeController.currentShipment[0].denKho,
                                startPickup:
                                    homeController.currentShipment[0].startPickup,
                                donePickup:
                                    homeController.currentShipment[0].donePickup,
                                outWhse: homeController.currentShipment[0].roiKho,
                                isBiker: authController.auth.single.isBiker,
                              ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => Expanded(
                  child: RefreshIndicator(
                    onRefresh: homeController.refreshData,
                    child: homeController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : !homeController.isLoading.value &&
                                homeController.currentShipmentStops.isEmpty &&
                                homeController.currentShipment.isEmpty
                            ? Center(
                                child: Text(
                                  homeController.currentShipment.isNotEmpty &&
                                          homeController
                                              .currentShipmentStops.isEmpty &&
                                          !homeController
                                              .currentShipment[0].roiKho
                                      ? ''
                                      : TextContent.noShipment,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              )
                            : !homeController.isLoading.value &&
                                    homeController.currentShipmentStops.isEmpty &&
                                    homeController.currentShipment.isNotEmpty &&
                                    homeController.currentShipment[0].roiKho
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (authController
                                                  .auth.single.isBiker ==
                                              'True') {
                                            Get.dialog(
                                                const DialogHoanThanhChuyenBiker());
                                          } else {
                                            Get.dialog(
                                                const DialogHoanThanhChuyen());
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Nhấn vào đây để hoàn thành nếu đã giao xong.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    cacheExtent: 10,
                                    itemCount: homeController
                                        .currentShipmentStops.length,
                                    itemBuilder: (ctx, index) => Obx(
                                      () => homeController
                                              .currentShipmentStops.isEmpty
                                          ? const SizedBox()
                                          : ShipmentStopItem(
                                              storeCode: homeController
                                                  .currentShipmentStops[index]
                                                  .storeCode,
                                              storeName: homeController
                                                  .currentShipmentStops[index]
                                                  .storeName,
                                              addressLine: homeController
                                                      .currentShipmentStops[index]
                                                      .addresSLINE ??
                                                  '',
                                              phoneNumber: homeController
                                                      .currentShipmentStops[index]
                                                      .customerClientPhone ??
                                                  'chưa xác định',
                                              isDaToi: homeController
                                                  .currentShipmentStops[index]
                                                  .daToi,
                                              isDetail: homeController
                                                  .currentShipmentStops[index]
                                                  .isDetails,
                                              totalCarton: homeController
                                                  .currentShipmentStops[index]
                                                  .totalCarton,
                                              atmOrderReleaseId: homeController
                                                  .currentShipmentStops[index]
                                                  .orderreleasEID,
                                              deliveryDate: DateTime.parse(
                                                  homeController
                                                      .currentShipmentStops[index]
                                                      .deliveryDate),
                                              btnClickDaToi: () {
                                                homeController.updateDaToi(
                                                    homeController
                                                        .currentShipmentStops[
                                                            index]
                                                        .storeCode,
                                                    homeController
                                                        .currentShipmentStops[
                                                            index]
                                                        .orderreleasEID);
                                              },
                                              customerCode: homeController
                                                  .currentShipmentStops[index]
                                                  .khachHang,
                                              totalWeight: homeController
                                                  .currentShipmentStops[index]
                                                  .totalWeight
                                                  .toString(),
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
