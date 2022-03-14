import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/giao_chi_tiet_controller.dart';

class GiaoThungScreen extends StatelessWidget {
  const GiaoThungScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GiaoChiTietController gctController;
    gctController = Get.isRegistered<GiaoChiTietController>()
        ? Get.find<GiaoChiTietController>()
        : Get.put(GiaoChiTietController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.btnGiaoThung),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GetBuilder<GiaoChiTietController>(
                init: gctController,
                builder: (data) => ListView.builder(
                  key: UniqueKey(),
                  cacheExtent: 10,
                  itemCount: data.basketList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Số rổ CH còn nợ: ',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Tên khay rổ: Khay/ thùng',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Số rổ đã nhận từ kho',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            initialValue: "0",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Số rổ đã giao CH',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            initialValue: "0",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Số rổ đã nhận từ CH',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            initialValue: "0",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextContent.btnXacNhanKhayRo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
