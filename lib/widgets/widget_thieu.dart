import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Controllers
import '../controllers/home_controller.dart';
// Text Content
import '../constants/text_content.dart';

class WidgetThieu extends StatelessWidget {
  const WidgetThieu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: homeController.cbThieu.value,
            onChanged: (bool? value) {
              homeController.cbThieu.value = value!;
              if (!value) {
                homeController.totalCarton.value += homeController.valueCbThieu.value;
                homeController.valueCbThieu.value = 0;
              }
            },
          ),
        ),
        const Text(TextContent.thieu),
        IconButton(
          onPressed: () {
            if (homeController.cbThieu.value) {
              if (homeController.valueCbThieu.value > 0) {
                homeController.valueCbThieu.value--;
                homeController.totalCarton.value++;
              }
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Obx(
          () => Text(homeController.valueCbThieu.value.toString()),
        ),
        IconButton(
          onPressed: () {
            if (homeController.cbThieu.value) {
              if (homeController.totalCarton.value != 0) {
                homeController.valueCbThieu.value++;
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
