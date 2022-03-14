import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Constants
import '../constants/text_content.dart';

// Controllers
import '../controllers/phi_controller.dart';

class DeNghiTamUngDetailScreen extends StatelessWidget {
  const DeNghiTamUngDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    var index = arguments[0]['index'];
    var formatCurrency = NumberFormat.currency(locale: "vi_VN");

    PhiController phiController;
    phiController = Get.isRegistered<PhiController>()
        ? Get.find<PhiController>()
        : Get.put(PhiController());

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 640,
                height: 480,
                child: Obx(
                  () => phiController.isLoading4.value
                      ? const Center(child: CircularProgressIndicator())
                      : !phiController.isLoading4.value &&
                              phiController.expenseImageList.isEmpty
                          ? const Center(
                              child: Text('Không có hình ảnh để hiển thị'),
                            )
                          : ListView.builder(
                              key: UniqueKey(),
                              scrollDirection: Axis.horizontal,
                              cacheExtent: 10,
                              itemCount: phiController.expenseImageList.length,
                              itemBuilder: (context, index) => SizedBox(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '${TextContent.imageUrl}${phiController.expenseImageList[index].attachName}',
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    BottomSheetDetailWidget(
                      mIndex: index,
                      advancePaymentType:
                          phiController.tamUngList[index].advancePaymentType,
                      driverId: phiController.tamUngList[index].employeeID,
                      driverName: phiController.tamUngList[index].employeeName,
                      atmShipment:
                          phiController.tamUngList[index].atmShipmentID ??
                              'Không có',
                      otmShipment:
                          phiController.tamUngList[index].otmsHipmentID ??
                              'Không có',
                      opAmount: formatCurrency
                          .format(phiController.tamUngList[index].opAmount),
                      department: phiController.tamUngList[index].department,
                      remark:
                          phiController.tamUngList[index].remark ?? 'Không có',
                      customer: phiController.tamUngList[index].customer ??
                          'Không có',
                      invoiceNumber:
                          phiController.tamUngList[index].invoiceNumber,
                      amount: formatCurrency
                          .format(phiController.tamUngList[index].amount),
                      createDate: DateFormat('dd-MM-yyyy HH:mm').format(
                          DateTime.parse(
                              phiController.tamUngList[index].createDate)),
                      description:
                          phiController.tamUngList[index].description ??
                              'Không có',
                      finAmount: formatCurrency
                          .format(phiController.tamUngList[index].finAmount),
                      id: phiController.tamUngList[index].id,
                    ),
                  );
                },
                child: const Text('Hiển thị thêm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetDetailWidget extends StatelessWidget {
  final String advancePaymentType,
      driverId,
      driverName,
      atmShipment,
      otmShipment,
      invoiceNumber,
      finAmount,
      opAmount,
      department,
      customer,
      amount,
      remark,
      description,
      createDate;

  final int id, mIndex;

  const BottomSheetDetailWidget(
      {Key? key,
      required this.advancePaymentType,
      required this.driverId,
      required this.driverName,
      required this.atmShipment,
      required this.otmShipment,
      required this.invoiceNumber,
      required this.finAmount,
      required this.opAmount,
      required this.department,
      required this.customer,
      required this.amount,
      required this.remark,
      required this.description,
      required this.createDate,
      required this.id,
      required this.mIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phiController = Get.find<PhiController>();

    return LayoutBuilder(
      builder: (context, constraints) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Ẩn đi'),
                        ),
                      ),
                      PopupMenuButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.blue,
                          ),
                          onSelected: (selection) {
                            switch (selection) {
                              case 1:
                                Get.defaultDialog(
                                    middleText: '',
                                    title: 'Bạn có chắc là muốn xóa phí ?',
                                    textConfirm: 'Đồng ý',
                                    textCancel: 'Hủy',
                                    onConfirm: () {
                                      phiController.deleteTamUng(mIndex);
                                    },
                                    onCancel: () {
                                      Get.back();
                                    });
                                break;
                              case 2:
                                Get.dialog(DialogEditTamUng(mIndex: mIndex));
                                break;
                              case 3:
                                phiController.openDialogCamera1(mIndex);
                                break;
                              case 4:
                                phiController.deleteImageTamUng(mIndex, id);
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: Text('Xóa phí'),
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text('Sửa phí'),
                                  value: 2,
                                ),
                                const PopupMenuItem(
                                  child: Text('Thêm hình'),
                                  value: 3,
                                ),
                                const PopupMenuItem(
                                  child: Text('Xóa hình hiện tại'),
                                  value: 4,
                                ),
                              ])
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        advancePaymentType,
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.back();
                            phiController.expenseImageList.assignAll([]);
                            phiController.expenseImageList.refresh();
                            phiController.fetchExpenseImage1(id);
                          },
                          child: const Text('Hiển thị\nhình ảnh'))
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Tên : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        driverName,
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã nhân viên : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        driverId,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã ATM : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        atmShipment,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã OTM : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        otmShipment,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã đơn tạm ứng : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        invoiceNumber,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Trưởng BP : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        opAmount,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Kế toán : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        finAmount,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã bộ phận : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        department,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mã khách hàng : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        customer,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Số tiền tạm ứng : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        amount,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Lí do không duyệt : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        remark,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text(
                        'Mô tả : ',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    createDate,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogEditTamUng extends StatelessWidget {
  final int mIndex;

  const DialogEditTamUng({Key? key, required this.mIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phiController = Get.find<PhiController>();
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Center(
        child: Form(
          key: phiController.dialogEditTamUngKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Số tiền tạm ứng cần chỉnh sửa',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    initialValue: CurrencyTextInputFormatter(
                      decimalDigits: 0,
                      symbol: '',
                    ).format(
                        phiController.tamUngList[mIndex].amount.toString()),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        decimalDigits: 0,
                        symbol: '',
                      )
                    ],
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
                      labelText: 'Ghi chú cần chỉnh sửa (nếu có)',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    initialValue: phiController.tamUngList[mIndex].description,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      phiController.noteTamUng.value = val!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Hủy'),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          phiController.updateTamUng(mIndex);
                        },
                        child: const Text('Đồng ý'),
                      )),
                    ],
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
