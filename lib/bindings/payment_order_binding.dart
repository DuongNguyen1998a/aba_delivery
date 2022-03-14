import '../controllers/payment_order_controller.dart';
import 'package:get/get.dart';

class PaymentOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentOrderController>(() => PaymentOrderController());
  }
}