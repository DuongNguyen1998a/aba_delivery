import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controllers
import '../controllers/home_controller.dart';

class DialogHoanThanhChuyen extends StatelessWidget {
  const DialogHoanThanhChuyen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return AlertDialog(
      title: const Text(
        'Chụp chứng từ để kết thúc chuyến',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                homeController.openDialogCamera1();
              },
              child: const Text('Thêm hình'),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => homeController.listImageCompleteShipment.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        key: UniqueKey(),
                        scrollDirection: Axis.horizontal,
                        cacheExtent: 10,
                        itemCount:
                            homeController.listImageCompleteShipment.length,
                        itemBuilder: (context, index) => Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Badge(
                            padding: const EdgeInsets.all(0),
                            badgeColor: Colors.white,
                            badgeContent: SizedBox(
                              width: 20,
                              height: 20,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  homeController.listImageCompleteShipment
                                      .removeAt(index);
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  size: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            child: Image.file(
                              File(homeController
                                  .listImageCompleteShipment[index].path),
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            homeController.listImageCompleteShipment.assignAll([]);
            Get.back();
          },
          child: const Text('Hủy'),
        ),
        Obx(
          () => homeController.isLoadingADCAD.value
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    homeController.addADCAD();
                  },
                  child: const Text('Gửi đi'),
                ),
        ),
      ],
    );
  }
}
