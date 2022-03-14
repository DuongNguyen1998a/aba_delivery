import 'package:get/get.dart';
// Controllers
import '../controllers/problem_controller.dart';

class ProblemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProblemController>(() => ProblemController());
  }
}