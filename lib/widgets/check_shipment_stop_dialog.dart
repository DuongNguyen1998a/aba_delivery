import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chuyenxe_controller.dart';
import '../widgets/check_shipment_stop_item.dart';

class CheckShipmentStopDialog extends StatelessWidget {
  const CheckShipmentStopDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChuyenXeController chuyenXeController =
        Get.find<ChuyenXeController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chuyenXeController.checkShipmentStops.length,
                itemBuilder: ((context, index) => CheckShipmentStopItem(
                      storeCode: chuyenXeController
                          .checkShipmentStops[index].storeCode,
                      storeName: chuyenXeController
                          .checkShipmentStops[index].storeName,
                      addressLine: chuyenXeController
                          .checkShipmentStops[index].addresSLINE ?? '',
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Đóng'),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent
              ),
            ),
          ],
        ),
      ),
    );
  }
}
