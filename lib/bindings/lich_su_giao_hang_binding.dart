import 'package:get/get.dart';
// Controllers
import '../controllers/lich_su_giao_hang_controller.dart';

class LichSuGiaoHangBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LichSuGiaoHangController>(() => LichSuGiaoHangController());
  }
}