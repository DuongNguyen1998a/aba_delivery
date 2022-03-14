import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/controllers/payment_order_controller.dart';
import 'package:flutter_aba_delivery_app_getx/models/shipment_order_payment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/payment_order_controller.dart';

class DeNghiThanhToanAddScreen extends StatelessWidget {
  const DeNghiThanhToanAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOfScreen = MediaQuery.of(context).size.width;
    var formatCurrency = NumberFormat.currency(locale: "vi_VN");

    PaymentOrderController poController = Get.put(PaymentOrderController());
    // poController = Get.isRegistered<PaymentOrderController>()
    //     ? Get.find<PaymentOrderController>()
    //     : Get.put(PaymentOrderController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextContent.createNewPaymentOrder,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: poController.paymentOrderForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      width: widthOfScreen,
                      height: heightOfScreen * 0.2,
                      color: Colors.blueGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Obx(
                              () => poController.imagePickerList.isEmpty
                                  ? const SizedBox()
                                  : ListView.builder(
                                      key: UniqueKey(),
                                      scrollDirection: Axis.horizontal,
                                      cacheExtent: 10,
                                      itemCount:
                                          poController.imagePickerList.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.file(
                                              File(poController
                                                  .imagePickerList[index]!
                                                  .path),
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fill,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                poController.imagePickerList
                                                    .removeAt(index);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              poController.openDialogCamera(1, 0);
                            },
                            icon: const Icon(
                              Icons.camera,
                              color: Colors.orangeAccent,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  TextContent.paymentOrderNote,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    TextContent.paymentOrderPickShipment,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Obx(
                  () => poController.shipmentPaymentOrderList.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                            itemHeight: 120,
                            isExpanded: true,
                            underline: const SizedBox(),
                            value: poController
                                        .currentShipmentPaymentOrder.value ==
                                    ''
                                ? poController
                                    .shipmentPaymentOrderList[0].atmShipmentID
                                : poController
                                    .currentShipmentPaymentOrder.value,
                            onChanged: (newValue) {
                              poController.currentShipmentPaymentOrder.value =
                                  newValue! as String;
                            },
                            items: poController.shipmentPaymentOrderList
                                .map((shipment) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: widthOfScreen * 0.7,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${shipment.atmShipmentID}\n${ShipmentOrderPayment.getCustomerCode(shipment.customerCode, shipment.packagedItem)}\n${DateFormat('dd-MM-yyyy').format(DateTime.parse(shipment.startTime))}\nTiền tạm ứng: ${formatCurrency.format(shipment.amount)}\nChi phí: ${formatCurrency.format(shipment.amountTotal)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                value: shipment.atmShipmentID,
                              );
                            }).toList(),
                          ),
                        ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    TextContent.paymentOrderPickFeeType,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Obx(
                  () => poController.feeTypeList.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                            value: poController.currentFee.value == ''
                                ? poController.feeTypeList[0].iDLoaiPhi
                                : poController.currentFee.value,
                            onChanged: (val) {
                              poController.currentFee.value = val! as String;
                            },
                            items: poController.feeTypeList.map((element) {
                              return DropdownMenuItem(
                                child: Text(element.tenLoaiPhi ?? ''),
                                value: element.iDLoaiPhi,
                              );
                            }).toList(),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Colors.blue,
                      ),
                      labelText: TextContent.paymentOrderAmount,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (String val) {
                      if (val.isEmpty) {
                        poController.paymentOrderAmount.value = 0;
                      } else if (val.isNotEmpty) {
                        poController.paymentOrderAmount.value = int.parse(val);
                      }
                    },
                  ),
                ),
                Obx(() => poController.currentFee.value == 'TOLL'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (poController.numberToll.value != 0) {
                                  poController.numberToll.value--;
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.orangeAccent,
                              )),
                          Obx(
                            () =>
                                Text(poController.numberToll.value.toString()),
                          ),
                          IconButton(
                              onPressed: () {
                                if (poController.numberToll.value < 4) {
                                  poController.numberToll.value++;
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.orangeAccent,
                              ))
                        ],
                      )
                    : const SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                    () => poController.shipmentPaymentOrderList.isEmpty
                        ? const SizedBox()
                        : Text(
                            'Tiền đã tạm ứng (a) : ${formatCurrency.format(poController.getSoTienTamUng(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value))}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => poController.shipmentPaymentOrderList.isEmpty
                        ? const SizedBox()
                        : Text(
                            'Tiền đã đề nghị (b) : ${formatCurrency.format(poController.currentFee.value == 'TOLL' ? poController.getSoTienDeNghi(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value)! + (poController.paymentOrderAmount.value * poController.numberToll.value) : poController.getSoTienDeNghi(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value)! + poController.paymentOrderAmount.value)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                    () => poController.shipmentPaymentOrderList.isEmpty
                        ? const SizedBox()
                        : Text(
                            'Còn lại (a - b) : ${formatCurrency.format(poController.getSoTienTamUng(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value)! - (poController.currentFee.value == 'TOLL' ? poController.getSoTienDeNghi(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value)! + (poController.paymentOrderAmount.value * poController.numberToll.value) : poController.getSoTienDeNghi(poController.currentShipmentPaymentOrder.value == '' ? poController.shipmentPaymentOrderList[0].atmShipmentID : poController.currentShipmentPaymentOrder.value)! + poController.paymentOrderAmount.value))}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Colors.blue,
                      ),
                      labelText: TextContent.note,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    onSaved: (val) {
                      poController.paymentOrderDescription.value = val!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Obx(
                    () => poController.isLoadingSendPaymentOrder.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              poController.sendPaymentOrder();
                            },
                            child: const Text(TextContent.btnDeNghi2),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
