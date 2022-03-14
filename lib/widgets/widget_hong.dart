import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/home_controller.dart';

class WidgetHong extends StatelessWidget {
  const WidgetHong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Row(
      children: [
        Obx(
              () => Checkbox(
            value: homeController.cbHong.value,
            onChanged: (bool? value) {
              homeController.cbHong.value = value!;
              if (!value) {
                homeController.totalCarton.value += homeController.valueCbHong.value;
                homeController.valueCbHong.value = 0;
              }
            },
          ),
        ),
        const Text(TextContent.hong),
        IconButton(
          onPressed: () {
            if (homeController.cbHong.value) {
              if (homeController.valueCbHong.value > 0) {
                homeController.valueCbHong.value--;
                homeController.totalCarton.value++;
              }
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Obx(
              () => Text(homeController.valueCbHong.value.toString()),
        ),
        IconButton(
          onPressed: () {
            if (homeController.cbHong.value) {
              if (homeController.totalCarton.value != 0) {
                homeController.valueCbHong.value++;
                homeController.totalCarton.value--;
              }
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
