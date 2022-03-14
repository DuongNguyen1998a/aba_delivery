import 'package:flutter_aba_delivery_app_getx/controllers/gas_controller.dart';
import 'package:get/get.dart';

class GasBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasController>(() => GasController());
  }

}