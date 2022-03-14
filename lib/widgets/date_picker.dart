import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Controllers
import '../controllers/chuyenxe_controller.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChuyenXeController chuyenXeController =
        Get.find<ChuyenXeController>();

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              chuyenXeController.previousDate();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              size: 24,
              color: Colors.blueGrey,
            ),
          ),
          Card(
            elevation: 5,
            child: Obx(
              () => TextButton(
                onPressed: () {
                  chuyenXeController.showDatePickerDialog(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    DateFormat('dd/MM/yyyy')
                        .format(chuyenXeController.selectedDate.value),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              chuyenXeController.nextDate();
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 24,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
