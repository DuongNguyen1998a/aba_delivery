import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Text Contents
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';
import '../controllers/lenh_dieu_dong_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';

class LenhDieuDongScreen extends StatelessWidget {
  const LenhDieuDongScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController;
    LenhDieuDongController lddController;

    authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    lddController = Get.isRegistered<LenhDieuDongController>()
        ? Get.find<LenhDieuDongController>()
        : Get.put(LenhDieuDongController());

    void signOut() async {
      await authController.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleLddScreen),
      ),
      drawer: AppDrawer(
        fullName: authController.auth.first.fullName,
        position: authController.auth.first.position,
        isBiker: authController.auth.first.isBiker,
        driverId: authController.auth.first.driverId,
        signOut: signOut,
      ),
      body: Center(
        child: Obx(
          () => lddController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : !lddController.isLoading.value &&
                      lddController.lddList.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lddController.lddList[0].atMSHIPMENTId,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        QrImage(
                          data: lddController.lddList[0].atMSHIPMENTId,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        TextContent.noLdd,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
