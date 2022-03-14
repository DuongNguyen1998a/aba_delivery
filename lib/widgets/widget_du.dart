import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/home_controller.dart';

class WidgetDu extends StatelessWidget {
  const WidgetDu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: homeController.cbDu.value,
            onChanged: (bool? value) {
              homeController.cbDu.value = value!;
              if (!value) {
                homeController.totalCarton.value += homeController.valueCbDu.value;
                homeController.valueCbDu.value = 0;
              }
            },
          ),
        ),
        const Text(TextContent.du),
        IconButton(
          onPressed: () {
            if (homeController.cbDu.value) {
              if (homeController.valueCbDu.value > 0) {
                homeController.valueCbDu.value--;
                homeController.totalCarton.value++;
              }
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Obx(
          () => Text(homeController.valueCbDu.value.toString()),
        ),
        IconButton(
          onPressed: () {
            if (homeController.cbDu.value) {
              if (homeController.totalCarton.value != 0) {
                homeController.valueCbDu.value++;
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
