import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/home_controller.dart';

class WidgetNhietDoKem extends StatelessWidget {
  const WidgetNhietDoKem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Row(
      children: [
        Obx(
              () => Checkbox(
            value: homeController.cbKem.value,
            onChanged: (bool? value) {
              homeController.cbKem.value = value!;
              if (!value) {
                homeController.totalCarton.value += homeController.valueCbKem.value;
                homeController.valueCbKem.value = 0;
              }
            },
          ),
        ),
        const Text(TextContent.nhietDoKem),
        IconButton(
          onPressed: () {
            if (homeController.cbKem.value) {
              if (homeController.valueCbKem.value > 0) {
                homeController.valueCbKem.value--;
                homeController.totalCarton.value++;
              }
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Obx(
              () => Text(homeController.valueCbKem.value.toString()),
        ),
        IconButton(
          onPressed: () {
            if (homeController.cbKem.value) {
              if (homeController.totalCarton.value != 0) {
                homeController.valueCbKem.value++;
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
