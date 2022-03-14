import '../controllers/phi_controller.dart';
import 'package:get/get.dart';

class PhiBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhiController>(() => PhiController());
  }
}