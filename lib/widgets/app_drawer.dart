import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/lenh_dieu_dong_controller.dart';
import '/controllers/lich_su_giao_hang_controller.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';
import '../controllers/chung_tu_controller.dart';

// Controllers
import '../controllers/chuyenxe_controller.dart';
import '../controllers/gas_controller.dart';
import '../controllers/giao_bu_controller.dart';
import '../controllers/gop_y_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/phi_controller.dart';

// Screens
import '../views/change_password_modal.dart';

// Widgets
import '../widgets/menu_item.dart';

class AppDrawer extends StatelessWidget {
  final String fullName, driverId;
  final String position, isBiker;
  final Function signOut;

  const AppDrawer(
      {Key? key,
      required this.fullName,
      required this.position,
      required this.isBiker,
      required this.signOut,
      required this.driverId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverOrBiker = isBiker == 'True' ? ' - Biker' : ' - Driver';

    void openModalChangePassword() {
      Get.bottomSheet(const ChangePasswordModal());
    }

    void menuItemClick(String routeName) {
      Get.back();
      if (routeName == AppRoutes.homeLink) {
        Get.delete<HomeController>();
        Get.toNamed(AppRoutes.homeLink);
      } else if (routeName == AppRoutes.lddLink) {
        Get.delete<LenhDieuDongController>();
        Get.toNamed(AppRoutes.lddLink);
      } else if (routeName == AppRoutes.chuyenxeLink) {
        Get.delete<ChuyenXeController>();
        Get.toNamed(AppRoutes.chuyenxeLink);
      } else if (routeName == AppRoutes.lichSuGiaoHangLink) {
        Get.delete<LichSuGiaoHangController>();
        Get.toNamed(AppRoutes.lichSuGiaoHangLink);
      } else if (routeName == AppRoutes.chungTuLink) {
        Get.delete<ChungTuController>();
        Get.toNamed(AppRoutes.chungTuLink);
      } else if (routeName == AppRoutes.phiLink) {
        Get.delete<PhiController>();
        Get.delete<GopYController>();
        Get.toNamed(AppRoutes.phiLink);
      } else if (routeName == AppRoutes.gasLink) {
        Get.delete<GasController>();
        Get.toNamed(AppRoutes.gasLink);
      } else if (routeName == AppRoutes.giaoBuLink) {
        Get.delete<GiaoBuController>();
        Get.toNamed(AppRoutes.giaoBuLink);
      }
    }

    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: ListTile(
                  title: Text('$fullName - $driverId'),
                  subtitle: Text(position == 'NVGN'
                      ? '${TextContent.titleNVGN} $driverOrBiker'
                      : '$position $driverOrBiker'),
                  trailing: IconButton(
                    onPressed: () {
                      Get.back();
                      signOut();
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
              MenuItem(
                mIcon: Icons.home_outlined,
                iconColor: Colors.orangeAccent,
                title: TextContent.titleHomeScreen,
                onClick: () {
                  menuItemClick(AppRoutes.homeLink);
                },
              ),
              Visibility(
                visible: isBiker == 'True' ? false : true,
                child: MenuItem(
                  mIcon: Icons.qr_code_outlined,
                  iconColor: Colors.orangeAccent,
                  title: TextContent.titleLddScreen,
                  onClick: () {
                    menuItemClick(AppRoutes.lddLink);
                  },
                ),
              ),
              MenuItem(
                mIcon: Icons.car_rental_outlined,
                iconColor: Colors.orangeAccent,
                title: TextContent.titleChuyenXeScreen,
                onClick: () {
                  menuItemClick(AppRoutes.chuyenxeLink);
                },
              ),
              Visibility(
                visible: isBiker == 'True' ? true : false,
                child: MenuItem(
                  mIcon: Icons.car_rental_outlined,
                  iconColor: Colors.orangeAccent,
                  title: 'Giao bù',
                  onClick: () {
                    menuItemClick(AppRoutes.giaoBuLink);
                  },
                ),
              ),
              Visibility(
                visible: isBiker == 'True' ? false : true,
                child: MenuItem(
                  mIcon: Icons.message_outlined,
                  iconColor: Colors.orangeAccent,
                  title: 'Chứng từ',
                  onClick: () {
                    menuItemClick(AppRoutes.chungTuLink);
                  },
                ),
              ),
              Visibility(
                visible: isBiker == 'True' ? false : true,
                child: MenuItem(
                  mIcon: Icons.attach_money_outlined,
                  iconColor: Colors.orangeAccent,
                  title: 'Phí',
                  onClick: () {
                    menuItemClick(AppRoutes.phiLink);
                  },
                ),
              ),
              MenuItem(
                mIcon: Icons.history_outlined,
                iconColor: Colors.orangeAccent,
                title: 'Lịch sử giao hàng',
                onClick: () {
                  menuItemClick(AppRoutes.lichSuGiaoHangLink);
                },
              ),
              // MenuItem(
              //   mIcon: Icons.qr_code_outlined,
              //   iconColor: Colors.orangeAccent,
              //   title: 'Cập nhật app',
              //   onClick: () {
              //     //menuItemClick(AppRoutes.lddLink);
              //   },
              // ),
              Visibility(
                visible: isBiker == 'True' ? false : true,
                child: MenuItem(
                  mIcon: Icons.local_gas_station_outlined,
                  iconColor: Colors.orangeAccent,
                  title: 'Đổ dầu (lái xe)',
                  onClick: () {
                    menuItemClick(AppRoutes.gasLink);
                  },
                ),
              ),
              MenuItem(
                mIcon: Icons.password,
                iconColor: Colors.orangeAccent,
                title: TextContent.titleChangePassword,
                onClick: () {
                  Get.back();
                  openModalChangePassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
