import '../controllers/giao_chi_tiet_controller.dart';
import 'package:get/get.dart';

class GiaoChiTietBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiaoChiTietController>(() => GiaoChiTietController());
  }
}