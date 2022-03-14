import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

// App Routes
import '../constants/app_routes.dart';

// Text Contents
import '../constants/text_content.dart';
import '../controllers/giao_chi_tiet_controller.dart';

// Controllers
import '../controllers/home_controller.dart';

class ShipmentStopItem extends StatelessWidget {
  final String storeCode,
      storeName,
      addressLine,
      phoneNumber,
      atmOrderReleaseId,
      totalWeight;
  final DateTime deliveryDate;
  final bool isDaToi, isDetail;
  final int totalCarton;
  final Function btnClickDaToi;
  final String customerCode;

  const ShipmentStopItem({
    Key? key,
    required this.storeCode,
    required this.storeName,
    required this.addressLine,
    required this.phoneNumber,
    required this.atmOrderReleaseId,
    required this.deliveryDate,
    required this.isDaToi,
    required this.isDetail,
    required this.totalCarton,
    required this.btnClickDaToi,
    required this.customerCode,
    required this.totalWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final GiaoChiTietController giaoChiTietController =
        Get.find<GiaoChiTietController>();
    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );
    const mTextStyle16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
    );
    const mTextStyle14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
    );

    void openScreenGiaoChiTiet() {
      giaoChiTietController.isChecked.value = false;
      giaoChiTietController.sumTotalItem.value = 0;
      giaoChiTietController.countCheckedItem.value = 0;
      giaoChiTietController
          .fetchPhieuGiaoHang(storeCode,
              intl.DateFormat('yyyy-MM-dd').format(deliveryDate), customerCode)
          .then((_) {
        Get.toNamed(AppRoutes.giaoChiTietLink, arguments: [
          {'storeCode': storeCode},
          {'storeName': storeName},
          {'atmOrderReleaseId': atmOrderReleaseId},
          {'addressLine': addressLine},
          {'deliveryDate': deliveryDate},
          {'customerCode': customerCode},
        ]);
      });
    }

    void openScreenSaiLechHang() {
      homeController.totalCarton.value = totalCarton;
      homeController.setDefaultValue();
      Get.toNamed(AppRoutes.chupHinhGiaoHangLink, arguments: [
        {'storeCode': storeCode},
        {'storeName': storeName},
        {'atmOrderReleaseId': atmOrderReleaseId},
        {'addressLine': addressLine},
        {'deliveryDate': deliveryDate},
        {'totalCarton': totalCarton},
        {'totalWeight': totalWeight},
      ]);
    }

    void openScreenGiaoThung() {
      giaoChiTietController.fetchQuantityBasket(atmOrderReleaseId);
    }

    void deliveryHub() {
      Get.defaultDialog(
          title: '',
          middleText: 'Bạn chắc chắn giao Hub ? Nếu đúng hãy bấm đồng ý.',
          onConfirm: () {
            homeController.deliveryHub(
                storeCode,
                homeController.currentShipment[0].atMSHIPMENTID,
                atmOrderReleaseId);
            Get.back();
          },
          textCancel: 'Hủy',
          onCancel: () {
            Get.back();
          });
    }

    return Card(
      shape: const Border(
        bottom: BorderSide(color: Colors.orangeAccent, width: 5,),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              storeCode,
              style: mTextStyle16,
              textAlign: TextAlign.center,
            ),
            Text(
              storeName,
              style: mTextStyle14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${TextContent.addressLine}$addressLine',
              style: mTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '${TextContent.phoneNumber}$phoneNumber',
              style: mTextStyle,
            ),
            const SizedBox(
              height: 3,
            ),
            if (!isDetail)
              Text(
                '${TextContent.totalCarton}$totalCarton',
                style: mTextStyle,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Directionality(
                  //textDirection: TextDirection.RTL,
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    label: Text(
                      TextContent.btnDaToi,
                      style: TextStyle(
                          color: isDaToi ? Colors.white : Colors.blueGrey),
                    ),
                    onPressed: () {
                      isDaToi ? null : btnClickDaToi();
                    },
                    icon: isDaToi
                        ? Icon(
                            Icons.check,
                            color: isDaToi ? Colors.white : Colors.blueGrey,
                          )
                        : Icon(
                            Icons.radio_button_unchecked,
                            color: isDaToi ? Colors.white : Colors.blueGrey,
                          ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                            color: isDaToi ? Colors.green : Colors.blueGrey,
                            width: 1,
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          isDaToi ? Colors.green : Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.problemLink, arguments: [
                        {'storeCode': storeCode},
                        {'storeName': storeName},
                        {'atmOrderReleaseId': atmOrderReleaseId},
                        {'addressLine': addressLine},
                        {'deliveryDate': deliveryDate},
                        {'customerCode': customerCode},
                      ]);
                    },
                    child: const Text(
                      TextContent.btnSuCo,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!isDaToi) {
                        TextContent.getXSnackBar(
                            '', TextContent.vuiLongBamDaToi, true);
                      } else {
                        if (isDetail) {
                          openScreenGiaoChiTiet();
                        } else {
                          openScreenSaiLechHang();
                        }
                      }
                    },
                    child: Text(
                      isDetail
                          ? TextContent.btnGiaoChiTiet
                          : TextContent.btnSaiLechHang,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isDetail ? Colors.blue : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isDetail)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isDaToi) {
                          TextContent.getXSnackBar(
                              '', TextContent.vuiLongBamDaToi, true);
                        } else {
                          openScreenGiaoThung();
                        }
                      },
                      child: const Text(
                        TextContent.btnGiaoThung,
                      ),
                    ),
                  ),
              ],
            ),
            if (isDetail)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isDaToi) {
                          TextContent.getXSnackBar(
                              '', TextContent.vuiLongBamDaToi, true);
                        } else {
                          deliveryHub();
                        }
                      },
                      child: const Text(
                        TextContent.btnGiaoHub,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
