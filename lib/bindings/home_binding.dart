import 'package:get/get.dart';
// Controllers
import '../controllers/home_controller.dart';
import '../controllers/giao_chi_tiet_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GiaoChiTietController>(() => GiaoChiTietController());
  }
}