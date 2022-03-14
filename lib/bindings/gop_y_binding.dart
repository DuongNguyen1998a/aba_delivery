import '../controllers/gop_y_controller.dart';
import 'package:get/get.dart';

class GopYBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GopYController>(() => GopYController());
  }
}