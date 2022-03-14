import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/giao_chi_tiet_controller.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GiaoChiTietController gctController;

    gctController = Get.isRegistered<GiaoChiTietController>()
        ? Get.find<GiaoChiTietController>()
        : Get.put(GiaoChiTietController());

    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );

    final key = Get.arguments[0]['key'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Khay rổ'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GetBuilder<GiaoChiTietController>(
                  init: gctController,
                  builder: (data) => data.basketList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          key: UniqueKey(),
                          cacheExtent: 10,
                          itemCount: data.basketList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 8,
                            margin: const EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Form(
                                      key: key == 2
                                          ? data.updateBasketKey1
                                          : data.updateBasketKey,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Số rổ CH còn nợ :${data.basketList[index].quantityAfter ?? 0}',
                                            style: mTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Tên khay rổ : ' +
                                                data.basketList[index]
                                                    .basketName,
                                            style: mTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              labelText: 'Sổ rổ đã nhận từ kho',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                            ),
                                            initialValue:
                                                '${data.basketList[index].quantity ?? 0}',
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              labelText: 'Sổ rổ đã giao CH',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                            ),
                                            initialValue:
                                                '${data.basketList[index].quantityConfirmSendStore ?? 0}',
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'Số rổ giao CH không được để trống.';
                                              }
                                              return null;
                                            },
                                            onSaved: (val) {
                                              if (val!.isEmpty) {
                                                data.basketList[index]
                                                    .quantityConfirmSendStore = 0;
                                                data.basketList.refresh();
                                              }
                                              data.basketList[index]
                                                      .quantityConfirmSendStore =
                                                  int.parse(val);
                                              data.basketList.refresh();
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            //controller: data.basketReceivedStoreController,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(5),
                                              labelText: 'Sổ rổ đã nhận từ CH',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 1),
                                              ),
                                            ),
                                            initialValue:
                                                '${data.basketList[index].quantityConfirmReceivedStore ?? 0}',
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'Số rổ nhận từ CH không được để trống.';
                                              }
                                              return null;
                                            },
                                            onSaved: (val) {
                                              if (val!.isEmpty) {
                                                data.basketList[index]
                                                    .quantityConfirmReceivedStore = 0;
                                                data.basketList.refresh();
                                              }
                                              data.basketList[index]
                                                      .quantityConfirmReceivedStore =
                                                  int.parse(val);
                                              data.basketList.refresh();
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Obx(
                () => gctController.isLoadingKhayRo.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          gctController.updateBasketQuantity(
                              context, key);
                        },
                        child: const Text('Xác nhận đã giao / nhận từ CH'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
