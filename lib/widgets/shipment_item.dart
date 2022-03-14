import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/chuyenxe_controller.dart';
import '../widgets/check_shipment_stop_dialog.dart';

// Widgets
import '../widgets/tu_choi_shipment_modal.dart';

class ShipmentItem extends StatelessWidget {
  final String atmShipmentId, customerCode, routeNo;
  final DateTime fromDate, toDate;
  final int mKey;

  const ShipmentItem({
    Key? key,
    required this.atmShipmentId,
    required this.customerCode,
    required this.fromDate,
    required this.toDate,
    required this.routeNo,
    required this.mKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChuyenXeController chuyenXeController =
        Get.find<ChuyenXeController>();
    const mTextStyle16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
    );
    const mTextStyle14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
    );
    const mTextStyle13 = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
    );

    void openModalTuChoiShipment() {
      Get.bottomSheet(TuChoiShipmentModal(
        atmShipmentId: atmShipmentId,
        routeNo: routeNo,
        deliveryDate: fromDate,
      ));
    }

    void nhanChuyenShipment() {
      chuyenXeController.acceptedShipment(atmShipmentId);
    }

    void batDauChuyenShipment() {
      chuyenXeController.startShipment(atmShipmentId);
    }

    void checkShipmentStop() {
      chuyenXeController.fetchCheckShipmentStops(atmShipmentId, fromDate).then(
            (_) => Get.dialog(const CheckShipmentStopDialog()),
          );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              atmShipmentId,
              style: mTextStyle16,
            ),
            Text(customerCode, style: mTextStyle14),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy \nHH:mm:ss').format(fromDate),
                  style: mTextStyle13,
                  textAlign: TextAlign.center,
                ),
                const Icon(Icons.arrow_right_alt),
                Text(
                  DateFormat('dd/MM/yyyy \nHH:mm:ss').format(toDate),
                  style: mTextStyle13,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                checkShipmentStop();
              },
              child: const Text(
                TextContent.btnCheckStop,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              child: mKey != 1
                  ? Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => chuyenXeController.isLoading.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      batDauChuyenShipment();
                                    },
                                    child: const Text(TextContent.btnBatDau),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              openModalTuChoiShipment();
                            },
                            child: const Text(TextContent.btnTuChoi),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Obx(
                            () => chuyenXeController.isLoading.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      nhanChuyenShipment();
                                    },
                                    child:
                                        const Text(TextContent.btnNhanChuyen),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                    ),
                                  ),
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
