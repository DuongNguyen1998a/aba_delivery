import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/chung_tu_controller.dart';

class DialogCreateNewLicense extends StatelessWidget {
  const DialogCreateNewLicense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chungTuController = Get.find<ChungTuController>();

    const mTextStyle700 = TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.blueGrey,
      fontSize: 17,
    );
    const mTextStyle600 = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      fontSize: 14,
    );
    const mTextStyle500 = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey,
      fontSize: 14,
    );

    void confirmSendLicense() {
      chungTuController.createNewLicense(context);
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: chungTuController.licenseForm,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Hẹn nộp chứng từ trễ',
                  textAlign: TextAlign.center,
                  style: mTextStyle700,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Chọn mã chuyến',
                  style: mTextStyle600,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Obx(
                    () => chungTuController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : !chungTuController.isLoading.value &&
                                chungTuController.atmShipmentIdList.isEmpty
                            ? const Text(
                                'Thông báo: Bạn không có mã chuyến nào từ 3 ngày trở lại đây để đăng kí.',
                                style: mTextStyle500,
                              )
                            : DropdownButton(
                                itemHeight: 85,
                                isExpanded: true,
                                value: chungTuController
                                            .currentShipment.value ==
                                        ''
                                    ? chungTuController
                                        .atmShipmentIdList[0].atMSHIPMENTID
                                    : chungTuController.currentShipment.value,
                                onChanged: (val) {
                                  chungTuController.currentShipment.value =
                                      val! as String;
                                },
                                items: chungTuController.atmShipmentIdList
                                    .map((element) {
                                  return DropdownMenuItem(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(element.atMSHIPMENTID, style: mTextStyle500,),
                                        Text(element.customerCode ?? 'Khách hàng ghép', style: mTextStyle500,),
                                        Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(element.startTime)), style: mTextStyle500,),
                                      ],
                                    ),
                                    value: element.atMSHIPMENTID,
                                  );
                                }).toList(),
                              ),
                  ),
                ),
                const Text(
                  'Chọn ngày nộp',
                  style: mTextStyle600,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      chungTuController.openDatePicker(context);
                    },
                    child: Obx(
                      () => Text(
                        DateFormat('dd-MM-yyyy')
                            .format(chungTuController.selectedDate.value),
                        style: mTextStyle500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: TextContent.note,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  maxLines: 3,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Ghi chú là yêu cầu bắt buộc.\n Không được để trống';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    if (val!.isNotEmpty) {
                      chungTuController.note.value = val;
                    } else {
                      chungTuController.note.value = '';
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(TextContent.btnClose)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Obx(
                        () => chungTuController.isLoadingForm.value
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  confirmSendLicense();
                                },
                                child: const Text(TextContent.btnConfirm)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
