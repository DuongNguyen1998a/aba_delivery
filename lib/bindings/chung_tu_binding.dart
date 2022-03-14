import 'package:flutter_aba_delivery_app_getx/controllers/chung_tu_controller.dart';
import 'package:get/get.dart';

class ChungTuBinding implements Bindings {
   @override
  void dependencies() {
     Get.lazyPut<ChungTuController>(() => ChungTuController());
  }
}