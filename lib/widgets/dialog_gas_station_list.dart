import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gas_controller.dart';

class DialogGasStationList extends StatelessWidget {
  const DialogGasStationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gasController = Get.find<GasController>();

    void onItemClick(int index) {
      Get.back();
      gasController.setGasStationName(index);
    }

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Obx(
        () => ListView.builder(
          key: UniqueKey(),
          cacheExtent: 10,
          itemCount: gasController.gasStationList.length,
          itemBuilder: (context, index) => Card(
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child:
                GestureDetector(
                  onTap: () {
                    onItemClick(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(gasController.gasStationList[index].gasStationName ?? ''),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
