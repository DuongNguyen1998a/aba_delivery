import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/chung_tu_controller.dart';

class DialogEditLicense extends StatelessWidget {
  final String atmShipmentId,
      customerCode,
      startTime,
      statusManager,
      noteFromManage,
      note;

  final int id;

  final DateTime ngayNop;

  const DialogEditLicense({
    Key? key,
    required this.atmShipmentId,
    required this.customerCode,
    required this.startTime,
    required this.statusManager,
    required this.noteFromManage,
    required this.ngayNop,
    required this.note,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chungTuController = Get.find<ChungTuController>();

    const mTextStyle700 = TextStyle(
      fontWeight: FontWeight.w700,
    );

    const mTextStyle500 = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      content: Form(
        key: chungTuController.licenseEditForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Thông tin phiếu',
                style: mTextStyle700,
                textAlign: TextAlign.center,
              ),
              const Text(
                '(Có thể xem và chỉnh sửa, xóa)',
                style: mTextStyle500,
                textAlign: TextAlign.center,
              ),
              Text(
                atmShipmentId,
                style: mTextStyle700,
                textAlign: TextAlign.center,
              ),
              Text(
                customerCode,
                style: mTextStyle500,
                textAlign: TextAlign.center,
              ),
              Text(
                'chuyến ngày: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(startTime))}',
                style: mTextStyle700,
                textAlign: TextAlign.center,
              ),
              Text(
                statusManager,
                style: mTextStyle500,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: TextFormField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    chungTuController.openDatePickerEdit(context, ngayNop);
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Ngày nộp (Bắt buộc)',
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
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  controller: chungTuController.textController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú (Bắt buộc)',
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
                  initialValue: note,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Ghi chú không được bỏ trống.';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    chungTuController.note.value = val!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ghi chú của quản lí: $noteFromManage',
                  style: mTextStyle500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(TextContent.btnClose),
                    ),
                    Obx(
                      () => chungTuController.isLoadingDelete.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                chungTuController.deleteLicense(id);
                                Get.back();
                              },
                              child: const Text('Xóa'),
                            ),
                    ),
                    Obx(
                          () => chungTuController.isLoadingEdit.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () {
                          chungTuController.editLicense(id);
                          Get.back();
                        },
                        child: const Text('Sửa'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
