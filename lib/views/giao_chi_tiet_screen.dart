import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/giao_chi_tiet_controller.dart';

// Widgets
import '../widgets/giao_chi_tiet_item.dart';

class GiaoChiTietScreen extends StatelessWidget {
  const GiaoChiTietScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GiaoChiTietController giaoChiTietController;
    giaoChiTietController = Get.isRegistered<GiaoChiTietController>()
        ? Get.find<GiaoChiTietController>()
        : Get.put(GiaoChiTietController());

    var arguments = Get.arguments;
    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      overflow: TextOverflow.ellipsis,
    );
    const mTextStyle1 = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      overflow: TextOverflow.ellipsis,
      fontSize: 13,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextContent.titleGiaoChiTietScreen,
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Text(
                '${giaoChiTietController.countCheckedItem} / ${giaoChiTietController.phieuGiaoHangList.length}',
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                      Obx(
                        () => CheckboxListTile(
                          checkColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          title: const Text(
                            'Nhận giùm',
                            style: mTextStyle1,
                          ),
                          value: giaoChiTietController.isChecked.value,
                          onChanged: (value) {
                            giaoChiTietController.isChecked.value = value!;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                        () => giaoChiTietController.isChecked.value
                            ? LayoutBuilder(
                                builder: (context, constraints) => Row(
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.3,
                                      child: TextFormField(
                                        controller: giaoChiTietController
                                            .helpingStoreController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          labelText: 'Mã CH',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.1,
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.6,
                                      child: TextFormField(
                                        controller: giaoChiTietController
                                            .helpingReasonController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(5),
                                          labelText: 'Lí do',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<GiaoChiTietController>(
                init: GiaoChiTietController(),
                builder: (cont) => giaoChiTietController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        key: UniqueKey(),
                        cacheExtent: 10,
                        itemCount:
                            giaoChiTietController.phieuGiaoHangList.length,
                        itemBuilder: (context, index) => Obx(
                          () => GiaoChiTietItem(
                            itemName: giaoChiTietController
                                .phieuGiaoHangList[index].itemName,
                            divUnit: giaoChiTietController
                                .phieuGiaoHangList[index].divUnit,
                            soBich: giaoChiTietController
                                .phieuGiaoHangList[index].soBich
                                .toInt(),
                            mIndex: (index + 1),
                            isChecked: giaoChiTietController
                                .phieuGiaoHangList[index].isChecked,
                            onChangedValue: () {
                              giaoChiTietController.itemChecked(index);
                            },
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      giaoChiTietController.checkedAllItem();
                    },
                    child: const Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Tổng: ${giaoChiTietController.sumTotalItem.value}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      giaoChiTietController
                          .sendItem(arguments[2]['atmOrderReleaseId']);
                    },
                    child: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
