import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// TextContent
import '../constants/text_content.dart';

// Controllers
import '../controllers/home_controller.dart';

// Widgets
import '../widgets/home_header_button.dart';

class HomeHeader extends StatelessWidget {
  final String atmShipmentId;
  final String customerCode;
  final DateTime startDate;
  final DateTime endDate;
  final bool comeWhse, startPickup, donePickup, outWhse;
  final String isBiker;

  const HomeHeader({
    Key? key,
    required this.atmShipmentId,
    required this.customerCode,
    required this.startDate,
    required this.endDate,
    required this.comeWhse,
    required this.startPickup,
    required this.donePickup,
    required this.outWhse,
    required this.isBiker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              atmShipmentId,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              customerCode,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy \nHH:mm:ss').format(startDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 14,),
                  textAlign: TextAlign.center,
                ),
                const Icon(Icons.arrow_right_alt),
                Text(
                  DateFormat('dd/MM/yyyy \nHH:mm:ss').format(endDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            isBiker == 'True'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeHeaderButton(
                        btnContent: TextContent.btnDenHub,
                        btnValue: comeWhse,
                        btnClick: () {
                          homeController.updatePickupDepot('A');
                          homeController.fetchShipmentStops();
                          homeController.update();
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeHeaderButton(
                        btnContent: TextContent.btnDenKho,
                        btnValue: comeWhse,
                        btnClick: () {
                          homeController.updatePickupDepot('A');
                          homeController.update();
                        },
                      ),
                      HomeHeaderButton(
                        btnContent: TextContent.btnLayHang,
                        btnValue: startPickup,
                        btnClick: () {
                          homeController.updatePickupDepot('P');
                          homeController.update();
                        },
                      ),
                      HomeHeaderButton(
                        btnContent: TextContent.btnLayXong,
                        btnValue: donePickup,
                        btnClick: () {
                          homeController.updatePickupDepot('D');
                          homeController.update();
                        },
                      ),
                      HomeHeaderButton(
                        btnContent: TextContent.btnRoiKho,
                        btnValue: outWhse,
                        btnClick: () {
                          homeController.updatePickupDepot('L');
                          homeController.update();
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
