import 'package:get/get.dart';

// Bindings
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/chuyenxe_binding.dart';
import '../bindings/problem_binding.dart';
import '../bindings/giao_chi_tiet_binding.dart';
import '../bindings/lich_su_giao_hang_binding.dart';
import '../bindings/lenh_dieu_dong_binding.dart';
import '../bindings/phi_binding.dart';
import '../bindings/gop_y_binding.dart';
import '../bindings/payment_order_binding.dart';
import '../bindings/chung_tu_binding.dart';
import '../bindings/gas_binding.dart';
import '../bindings/giao_bu_binding.dart';

//Views
import '../views/auth_screen.dart';
import '../views/chuyen_xe_screen.dart';
import '../views/home_screen.dart';
import '../views/lenh_dieu_dong_screen.dart';
import '../views/splash_screen.dart';
import '../views/problem_screen.dart';
import '../views/giao_chi_tiet_screen.dart';
import '../views/lich_su_giao_hang_screen.dart';
import '../views/chung_tu_screen.dart';
import '../views/phi_screen.dart';
import '../views/giao_bu_screen.dart';
import '../views/sai_lech_hang_screen.dart';
import '../views/giao_thung_screen.dart';
import '../views/history_delivery_detail_screen.dart';
import '../views/lich_su_giao_hang_detail_screen.dart';
import '../views/de_nghi_tam_ung_screen.dart';
import '../views/de_nghi_tam_ung_detail_screen.dart';
import '../views/de_nghi_thanh_toan_screen.dart';
import '../views/de_nghi_thanh_toan_detail_screen.dart';
import '../views/de_nghi_tam_ung_add_screen.dart';
import '../views/de_nghi_thanh_toan_add_screen.dart';
import '../views/gop_y_screen.dart';
import '../views/gas_screen.dart';
import '../views/gas_current_request_screen.dart';
import '../views/gas_ticket_screen.dart';
import '../views/basket_screen.dart';

class AppRoutes {
  static const String authLink = '/auth';
  static const String homeLink = '/home';
  static const String splashLink = '/splash';
  static const String lddLink = '/ldd';
  static const String chuyenxeLink = '/chuyenxe';
  static const String problemLink = '/problem';
  static const String giaoChiTietLink = '/giaochitiet';
  static const String lichSuGiaoHangLink = '/lichsugiaohang';
  static const String chungTuLink = '/chungtu';
  static const String phiLink = '/phi';
  static const String giaoBuLink = '/giaobu';
  static const String chupHinhGiaoHangLink = '/chuphinhgiaohang';
  static const String giaoThungLink = '/giaothung';
  static const String lsghDetailLink = '/lsghdetail';
  static const String historyDeliveryDetailLink = '/historydeliverydetail';
  static const String deNghiTamUngLink = '/denghitamung';
  static const String deNghiTamUngDetailLink = '/denghitamungdetail';
  static const String deNghiThanhToanLink = '/denghithanhtoan';
  static const String deNghiThanhToanDetailLink = '/denghithanhtoandetail';
  static const String deNghiTamUngAddLink = '/denghitamungadd';
  static const String deNghiThanhToanAddLink = '/denghithanhtoanadd';
  static const String gopYLink = '/gopy';
  static const String gasLink = '/gas';
  static const String gasCurrentRequestLink = '/gascurrentreq';
  static const String gasTicketLink = '/gasticket';
  static const String basketLink = '/basket';

  static final pages = [
    GetPage(
      name: splashLink,
      page: () => const SplashScreen(),
      // transition: Transition.fadeIn,
      // transitionDuration: const Duration(milliseconds: 500),
      //binding: AuthBinding(),
    ),
    GetPage(
      name: authLink,
      page: () => const AuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: AuthBinding(),
    ),
    GetPage(
      name: homeLink,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: HomeBinding(),
    ),
    GetPage(
      name: lddLink,
      page: () => const LenhDieuDongScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: LenhDieuDongBinding(),
    ),
    GetPage(
      name: chuyenxeLink,
      page: () => const ChuyenXeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: ChuyenXeBinding(),
    ),
    GetPage(
      name: problemLink,
      page: () => const ProblemScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: ProblemBinding(),
    ),
    GetPage(
      name: giaoChiTietLink,
      page: () => const GiaoChiTietScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GiaoChiTietBinding(),
    ),
    GetPage(
      name: lichSuGiaoHangLink,
      page: () => const LichSuGiaoHangScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: LichSuGiaoHangBinding(),
    ),
    GetPage(
      name: chungTuLink,
      page: () => const ChungTuScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: ChungTuBinding(),
    ),
    GetPage(
      name: phiLink,
      page: () => const PhiScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding(),
    ),
    GetPage(
      name: giaoBuLink,
      page: () => const GiaoBuScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GiaoBuBinding(),
    ),
    GetPage(
      name: chupHinhGiaoHangLink,
      page: () => const SaiLechHangScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      //binding: GiaoChiTietBinding(),
    ),
    GetPage(
      name: giaoThungLink,
      page: () => const GiaoThungScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GiaoChiTietBinding(),
    ),
    GetPage(
      name: lsghDetailLink,
      page: () => const LichSuGiaoHangDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: LichSuGiaoHangBinding(),
    ),
    GetPage(
      name: historyDeliveryDetailLink,
      page: () => const HistoryDeliveryDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: LichSuGiaoHangBinding(),
    ),
    GetPage(
      name: deNghiTamUngLink,
      page: () => const DeNghiTamUngScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding(),
    ),
    GetPage(
      name: deNghiTamUngDetailLink,
      page: () => const DeNghiTamUngDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding()
    ),
    GetPage(
      name: deNghiThanhToanLink,
      page: () => const DeNghiThanhToanScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PaymentOrderBinding(),
    ),
    GetPage(
      name: deNghiThanhToanDetailLink,
      page: () => const DeNghiThanhToanDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding(),
    ),
    GetPage(
      name: deNghiTamUngAddLink,
      page: () => const DeNghiTamUngAddScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding(),
    ),
    GetPage(
      name: deNghiThanhToanAddLink,
      page: () => const DeNghiThanhToanAddScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: PhiBinding(),
    ),
    GetPage(
      name: gopYLink,
      page: () => const GopYScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GopYBinding(),
    ),
    GetPage(
      name: gasLink,
      page: () => const GasScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GasBinding(),
    ),
    GetPage(
      name: gasCurrentRequestLink,
      page: () => const GasCurrentRequestScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GasBinding(),
    ),
    GetPage(
      name: gasTicketLink,
      page: () => const GasTicketScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GasBinding(),
    ),
    GetPage(
      name: basketLink,
      page: () => const BasketScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      binding: GiaoChiTietBinding(),
    ),
  ];
}
