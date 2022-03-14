import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/home_controller.dart';
import '../widgets/widget_du.dart';
import '../widgets/widget_hong.dart';
import '../widgets/widget_nhiet_do_kem.dart';

// Widgets
import '../widgets/widget_thieu.dart';

class SaiLechHangScreen extends StatelessWidget {
  const SaiLechHangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController());
    var arguments = Get.arguments;
    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      overflow: TextOverflow.ellipsis,
    );

    void sendChupHinhGiaoHang() {
      homeController.updateStateStopDriver(
          arguments[0]['storeCode'],
          DateFormat('yyyy-MM-dd').format(arguments[4]['deliveryDate']),
          homeController.currentShipment[0].customerCode ?? '',
          homeController.currentShipment[0].atMSHIPMENTID,
          homeController.valueCbThieu.value,
          arguments[5]['totalCarton'].toInt() ==
                  homeController.totalCarton.value
              ? true
              : false,
          homeController.valueCbHong.value,
          homeController.valueCbDu.value,
          homeController.valueCbKem.value,
          homeController.totalCarton.value,
          arguments[6]['totalWeight'],
          arguments[2]['atmOrderReleaseId'],
          arguments[5]['totalCarton'].toInt());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chụp hình giao hàng'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Thời gian: ${DateFormat('dd-MM-yyyy').format(arguments[4]['deliveryDate'])}',
                          style: mTextStyle,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Mã cửa hàng: ${arguments[0]['storeCode']}',
                          style: mTextStyle,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Cửa hàng: ${arguments[1]['storeName']}',
                          style: mTextStyle,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Địa chỉ: ${arguments[3]['addressLine']}',
                          style: mTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                'SL lấy từ kho : ${arguments[5]['totalCarton']}'),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                  'SL giao CH : ${homeController.totalCarton.value}'),
                            ),
                          ),
                        ],
                      ),
                      const WidgetThieu(),
                      const WidgetDu(),
                      const WidgetHong(),
                      const WidgetNhietDoKem(),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: homeController.noteController,
                        decoration: const InputDecoration(
                          labelText: 'Ghi chú',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: Obx(
                          () => homeController.listImage.isEmpty
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      homeController.openDialogCamera();
                                    },
                                    child: const Text(
                                      'Vui lòng đính kèm ít nhất một hình (*)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (homeController.listImage.length ==
                                            3) {
                                          TextContent.getXSnackBar('',
                                              'Tối đa đính kèm 3 hình.', true);
                                        } else {
                                          homeController.openDialogCamera();
                                        }
                                      },
                                      child: const Text('Thêm hình'),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        key: UniqueKey(),
                                        cacheExtent: 10,
                                        itemCount:
                                            homeController.listImage.length,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Badge(
                                            badgeColor: Colors.white,
                                            badgeContent: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: IconButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onPressed: () {
                                                  homeController.listImage
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
                                                  .listImage[index].path),
                                              fit: BoxFit.fill,
                                              width: 80,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => homeController.isLoadingSaiHang.value
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  sendChupHinhGiaoHang();
                                },
                                child: const Text('Gửi đi'),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
