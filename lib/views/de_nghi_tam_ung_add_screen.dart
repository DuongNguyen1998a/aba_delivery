import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/phi_controller.dart';

// Models
import '../models/shipment_order_payment.dart';

class DeNghiTamUngAddScreen extends StatelessWidget {
  const DeNghiTamUngAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOfScreen = MediaQuery.of(context).size.width;

    PhiController phiController;
    phiController = Get.isRegistered<PhiController>()
        ? Get.find<PhiController>()
        : Get.put(PhiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo mới đề nghị tạm ứng',
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: phiController.tamUngKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              () => phiController.imageTamUngList.isEmpty
                                  ? const SizedBox()
                                  : ListView.builder(
                                      key: UniqueKey(),
                                      scrollDirection: Axis.horizontal,
                                      cacheExtent: 10,
                                      itemCount:
                                          phiController.imageTamUngList.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.file(
                                              File(phiController
                                                  .imageTamUngList[index]!
                                                  .path),
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fill,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                phiController.imageTamUngList
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
                              phiController.openDialogCamera();
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
                  '(*) Lưu ý: phí bồi thường thì mới cần hình ảnh, còn lại có thể không cần.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 9),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Chọn loại phí cần tạm ứng',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                    () => phiController.feeTypeList.isEmpty
                        ? const SizedBox()
                        : DropdownButton(
                            value: phiController.selectedDropdown.value,
                            onChanged: (newValue) {
                              phiController.selectedDropdown.value =
                                  newValue as int;
                            },
                            items: phiController.feeTypeList.map((e) {
                              return DropdownMenuItem(
                                child: Text(
                                  e.feeName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                value: e.id,
                              );
                            }).toList(),
                          ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Chọn chuyến cần tạm ứng',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                    () => phiController.shipmentAdvancePaymentList.isEmpty
                        ? const SizedBox()
                        : DropdownButton(
                            value: phiController.selectedDropdown1.value == ''
                                ? phiController
                                    .shipmentAdvancePaymentList[0].atmShipmentID
                                : phiController.selectedDropdown1.value,
                            onChanged: (newValue) {
                              phiController.selectedDropdown1.value =
                                  newValue as String;
                            },
                            items: phiController.shipmentAdvancePaymentList
                                .map((e) {
                              return DropdownMenuItem(
                                child: Column(
                                  children: [
                                    Text(
                                      e.atmShipmentID,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      ShipmentOrderPayment.getCustomerCode(
                                          e.customerCode, e.packagedItem),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                value: e.atmShipmentID,
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
                      labelText: 'Số tiền cần tạm ứng',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        decimalDigits: 0,
                        symbol: '',
                      )
                    ],
                    initialValue: '0',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Vùi lòng điền số tiền tạm ứng';
                      }
                      // else if (double.parse(val) < 500) {
                      //   return 'Phí tối thiểu là 500';
                      // }
                      return null;
                    },
                    onSaved: (val) {
                      phiController.amountTamUng.value =
                          int.parse(val!.replaceAll(',', ''));
                    },
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
                      labelText: 'Ghi chú (nếu có)',
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
                      phiController.noteTamUng.value = val!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      phiController.sendTamUng(context);
                    },
                    child: const Text('Tạm ứng'),
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
