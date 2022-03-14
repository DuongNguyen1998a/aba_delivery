import 'package:get/get.dart';
// Controllers
import '../controllers/chuyenxe_controller.dart';

class ChuyenXeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChuyenXeController>(() => ChuyenXeController());
  }
}