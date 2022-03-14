import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/gop_y_controller.dart';

class GopYScreen extends StatelessWidget {
  const GopYScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbController = Get.find<GopYController>();
    void openDialogGopY() {
      fbController.fetchShipmentOrderPayment().then(
            (_) => Get.dialog(
              const DialogGopY(),
            ),
          );
    }

    void onItemClick(int index) {
      Get.dialog(
        DialogItemClick(
          mIndex: index,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.btnGopY),
      ),
      body: SafeArea(
        child: Obx(
          () => fbController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : !fbController.isLoading.value && fbController.fbList.isEmpty
                  ? const Center(
                      child: Text(TextContent.noFeedback),
                    )
                  : RefreshIndicator(
                      onRefresh: fbController.fetchFeedback,
                      child: ListView.builder(
                        key: UniqueKey(),
                        cacheExtent: 10,
                        itemCount: fbController.fbList.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                onTap: () {
                                  onItemClick(index);
                                },
                                title: Text(fbController.fbList[index].title),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      fbController.fbList[index].content
                                                  .length >=
                                              20
                                          ? fbController.fbList[index].content
                                                  .substring(0, 20) +
                                              '...'
                                          : fbController.fbList[index].content,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy HH:mm:ss').format(
                                        DateTime.parse(fbController
                                            .fbList[index].createDate),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogGopY();
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class DialogGopY extends StatelessWidget {
  const DialogGopY({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbController = Get.find<GopYController>();
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: Form(
          key: fbController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => RadioListTile(
                    //toggleable: true,
                    title: const Text(
                      TextContent.radioBtn,
                      style: TextStyle(fontSize: 14),
                    ),
                    groupValue: fbController.radioGroup.value,
                    value: TextContent.radioBtn,
                    onChanged: (val) {
                      fbController.onchangedRadio(val.toString());
                    },
                  ),
                ),
                Obx(
                  () => RadioListTile(
                    //toggleable: true,
                    title: const Text(
                      TextContent.radioBtn1,
                      style: TextStyle(fontSize: 14),
                    ),
                    groupValue: fbController.radioGroup.value,
                    value: TextContent.radioBtn1,
                    onChanged: (val) {
                      fbController.onchangedRadio(val.toString());
                    },
                  ),
                ),
                Obx(
                  () => fbController.shipmentOrderPaymentList.isEmpty
                      ? const SizedBox()
                      : fbController.radioGroup.value == TextContent.radioBtn1
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                value: fbController.selectedDropdown.value == ''
                                    ? fbController.shipmentOrderPaymentList[0]
                                        .atmShipmentID
                                    : fbController.selectedDropdown.value,
                                onChanged: (newValue) {
                                  fbController.selectedDropdown.value =
                                      newValue as String;
                                },
                                items: fbController.shipmentOrderPaymentList
                                    .map((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e.atmShipmentID,
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
                        Icons.note,
                        color: Colors.blue,
                      ),
                      labelText: 'Tiêu đề',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    validator: (val) {
                      return fbController.validateTitle(val!);
                    },
                    onSaved: (val) {
                      fbController.title.value = val!;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Colors.blue,
                      ),
                      labelText: 'Nội dung',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    maxLines: 3,
                    validator: (val) {
                      return fbController.validateContent(val!);
                    },
                    onSaved: (val) {
                      fbController.content.value = val!;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Hủy'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            fbController
                                .addFeedback(context)
                                .then((_) => fbController.fetchFeedback());
                          },
                          child: const Text('Gửi'),
                        ),
                      ),
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

class DialogItemClick extends StatelessWidget {
  final int mIndex;

  const DialogItemClick({Key? key, required this.mIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbController = Get.find<GopYController>();

    const mTextStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    const mTextStyle1 = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w500,
    );

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 200, horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  fbController.fbList[mIndex].atmShipmentID ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                Wrap(
                  children: [
                    const Text(
                      'Loại: ',
                      style: mTextStyle,
                    ),
                    Text(
                      fbController.fbList[mIndex].type ?? '',
                      style: mTextStyle1,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      TextContent.title,
                      style: mTextStyle,
                    ),
                    Text(
                      fbController.fbList[mIndex].title,
                      style: mTextStyle1,
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    const Text(
                      TextContent.content,
                      style: mTextStyle,
                    ),
                    Text(
                      fbController.fbList[mIndex].content,
                      style: mTextStyle1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(TextContent.btnClose),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
