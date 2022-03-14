import 'package:flutter/material.dart';
import 'package:get/get.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Widgets
import '../widgets/app_drawer.dart';

class PhiScreen extends StatelessWidget {
  const PhiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());

    void signOut() async {
      await authController.signOut();
    }

    void goToDeNghiTamUng() {
      Get.toNamed(AppRoutes.deNghiTamUngLink);
    }

    void goToDeNghiThanhToan() {
      Get.toNamed(AppRoutes.deNghiThanhToanLink);
    }

    void goToGopY() {
      Get.toNamed(AppRoutes.gopYLink);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titlePhi),
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
        padding: const EdgeInsets.all(16),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                goToDeNghiTamUng();
              },
              icon: const Icon(Icons.add_outlined),
              label: const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(TextContent.btnDeNghi1),
              ),
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                goToDeNghiThanhToan();
              },
              icon: const Icon(
                Icons.add_outlined,
              ),
              label: const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  TextContent.btnDeNghi2,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                goToGopY();
              },
              icon: const Icon(
                Icons.add_outlined,
              ),
              label: const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  TextContent.btnGopY,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
