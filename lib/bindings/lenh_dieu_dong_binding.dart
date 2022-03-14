import '../controllers/lenh_dieu_dong_controller.dart';
import 'package:get/get.dart';

class LenhDieuDongBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LenhDieuDongController>(() => LenhDieuDongController());
  }
}