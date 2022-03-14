import 'dart:io';

import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

// Models
import '../models/dieu_dong.dart';

// Services
import '../services/lenh_dieu_dong_service.dart';

class LenhDieuDongController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var isLoading = false.obs;
  var lddList = <DieuDong>[].obs;

  @override
  void onInit() {
    fetchDieuDong();
    super.onInit();
  }

  Future<void> fetchDieuDong() async {
    try {
      isLoading(true);
      var result = await LenhDieuDongService.fetchDieuDong(
        authController.auth.single.driverId,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        lddList.assignAll(result);
      } else {
        lddList.assignAll([]);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
