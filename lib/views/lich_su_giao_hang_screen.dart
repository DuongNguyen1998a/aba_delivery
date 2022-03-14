import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Screens
import '../views/lich_su_giao_hang_tab1.dart';
import '../views/lich_su_giao_hang_tab2.dart';

// Widgets
import '../widgets/app_drawer.dart';

class LichSuGiaoHangScreen extends StatelessWidget {
  const LichSuGiaoHangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController;
    authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());
    void signOut() async {
      await authController.signOut();
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(TextContent.titleLichSuGiaoHang),
              bottom: const TabBar(
                labelColor: Colors.blueGrey,
                indicatorColor: Colors.orangeAccent,
                tabs: [
                  Tab(
                    text: TextContent.historyTab,
                  ),
                  Tab(
                    text: TextContent.deliveryTab,
                  ),
                ],
              ),
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
            body: const TabBarView(
              children: [
                // Tab 1 (Lịch sử)
                LichSuGiaoHangTab1(),
                // Tab 2 (Đã giao)
                LichSuGiaoHangTab2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
