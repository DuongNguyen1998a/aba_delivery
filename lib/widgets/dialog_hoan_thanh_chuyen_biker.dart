import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controllers
import '../controllers/home_controller.dart';

class DialogHoanThanhChuyenBiker extends StatelessWidget {
  const DialogHoanThanhChuyenBiker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      //clipBehavior: Clip.antiAliasWithSaveLayer,
      title: const Text('Thông báo'),
      content: const Text(
          'Bạn có chắc muốn hoàn thành chuyến xe (Hãy cân nhắc có thể vận hành chưa gán các điểm giao cho bạn)'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Hủy'),
        ),
        Obx(
          () => homeController.isLoadingADCADBiker.value ? const CircularProgressIndicator() : TextButton(
            onPressed: () {
              homeController.hoanThanhChuyenBiker();
            },
            child: const Text('Hoàn thành'),
          ),
        ),
      ],
    );
  }
}
