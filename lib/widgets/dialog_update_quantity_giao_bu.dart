import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Controllers
import '../controllers/giao_bu_controller.dart';

class DialogUpdateQuantityGiaoBu extends StatelessWidget {
  final String itemName, rowId;
  final double soBich, actualReceived;

  const DialogUpdateQuantityGiaoBu({
    Key? key,
    required this.itemName,
    required this.soBich,
    required this.actualReceived,
    required this.rowId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final gbController = Get.find<GiaoBuController>();

    return AlertDialog(
      title: Text(itemName, style: const TextStyle(fontSize: 16),),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'SL phải giao CH'),
              initialValue: '${soBich.toInt()}',
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(labelText: 'SL đã giao CH'),
              initialValue: '${actualReceived.toInt()}',
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'SL giao bù'),
              controller: gbController.quantityGiaoBuController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            gbController.updateQtyGiaoBu(rowId, context);
          },
          child: const Text('Đồng ý'),
        ),
      ],
    );
  }
}
