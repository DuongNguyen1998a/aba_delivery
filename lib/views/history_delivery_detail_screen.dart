import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/controllers/lich_su_giao_hang_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryDeliveryDetailScreen extends StatelessWidget {
  const HistoryDeliveryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LichSuGiaoHangController lsghController;
    lsghController = Get.isRegistered<LichSuGiaoHangController>()
        ? Get.find<LichSuGiaoHangController>()
        : Get.put(LichSuGiaoHangController());

    var arguments = Get.arguments;
    const mTextStyle =
        TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600);
    const mTextStyle1 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments[0]['atmShipmentId']),
      ),
      body: SafeArea(
        child: Obx(
          () => lsghController.isLoadingDeliveryDetail.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  key: UniqueKey(),
                  cacheExtent: 10,
                  itemCount: lsghController.historyDeliveryDetailList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            children: [
                              const Text(
                                'Mã CH : ',
                                style: mTextStyle,
                              ),
                              Text(
                                lsghController
                                    .historyDeliveryDetailList[index].storeCode,
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Tên CH : ',
                                style: mTextStyle,
                              ),
                              Text(
                                lsghController
                                    .historyDeliveryDetailList[index].storeName,
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Địa chỉ : ',
                                style: mTextStyle,
                              ),
                              Text(
                                lsghController.historyDeliveryDetailList[index]
                                    .addresSLINE,
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.orangeAccent,
                            thickness: 1.5,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Dự kiến : ',
                                style: mTextStyle,
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy HH:mm:ss').format(
                                    DateTime.parse(lsghController
                                        .historyDeliveryDetailList[index]
                                        .planneDARRIVAL)),
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'Hoàn thành : ',
                                style: mTextStyle,
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy HH:mm:ss').format(
                                    DateTime.parse(lsghController
                                        .historyDeliveryDetailList[index]
                                        .deliveryTime)),
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          if (lsghController.isShow(index) == 2)
                            WidgetShowOrHide(
                              textStyle1: mTextStyle1,
                              textStyle: mTextStyle,
                              thieu: lsghController
                                  .historyDeliveryDetailList[index].deficient,
                              du: lsghController
                                  .historyDeliveryDetailList[index].residual,
                              hong: lsghController
                                  .historyDeliveryDetailList[index].broken,
                              nhietDoKem: lsghController
                                  .historyDeliveryDetailList[index]
                                  .badTemperature,
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.orangeAccent,
                            thickness: 1.5,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'SL thùng lấy từ kho : ',
                                style: mTextStyle,
                              ),
                              Text(
                                lsghController.historyDeliveryDetailList[index]
                                    .totalCartonMasan
                                    .toString(),
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'SL thùng/khay giao CH : ',
                                style: mTextStyle,
                              ),
                              Text(
                                lsghController.historyDeliveryDetailList[index]
                                    .realNumDelivered
                                    .toString(),
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              const Text(
                                'SL thùng/khay điều chỉnh : ',
                                style: mTextStyle,
                              ),
                              Text(
                                '${lsghController.historyDeliveryDetailList[index].adJ_deliver_qty ?? 0}',
                                style: mTextStyle1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class WidgetShowOrHide extends StatelessWidget {
  final TextStyle textStyle;
  final TextStyle textStyle1;
  final int thieu, hong, du, nhietDoKem;

  const WidgetShowOrHide({
    Key? key,
    required this.textStyle,
    required this.textStyle1,
    required this.thieu,
    required this.hong,
    required this.du,
    required this.nhietDoKem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Colors.orangeAccent,
          thickness: 1.5,
          height: 1,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Thiếu',
                  style: textStyle,
                ),
                Text(
                  thieu.toString(),
                  style: textStyle1,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Hỏng',
                  style: textStyle,
                ),
                Text(
                  hong.toString(),
                  style: textStyle1,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Dư',
                  style: textStyle,
                ),
                Text(
                  du.toString(),
                  style: textStyle1,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '°C kém',
                  style: textStyle,
                ),
                Text(
                  nhietDoKem.toString(),
                  style: textStyle1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
