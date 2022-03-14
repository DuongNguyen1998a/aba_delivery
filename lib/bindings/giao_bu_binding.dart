import 'package:flutter_aba_delivery_app_getx/controllers/giao_bu_controller.dart';
import 'package:get/get.dart';

class GiaoBuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiaoBuController>(() => GiaoBuController());
  }

}