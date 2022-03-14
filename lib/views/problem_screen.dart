import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/problem_controller.dart';

class ProblemScreen extends StatelessWidget {
  const ProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProblemController problemController = Get.isRegistered<ProblemController>()
        ? Get.find<ProblemController>()
        : Get.put(ProblemController());

    const mTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey,
      overflow: TextOverflow.ellipsis,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleProblemScreen),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Thời gian: ${problemController.deliveryDate.value}',
                        style: mTextStyle,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Mã cửa hàng: ${problemController.storeCode.value}',
                        style: mTextStyle,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Cửa hàng: ${problemController.storeName.value}',
                        style: mTextStyle,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Địa chỉ: ${problemController.addressLine.value}',
                        style: mTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Form(
                key: problemController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Obx(
                          () => problemController.problemsList.isEmpty
                              ? const SizedBox()
                              : DropdownButton(
                                  value:
                                      problemController.selectedDropdown.value,
                                  onChanged: (newValue) {
                                    problemController.selectedDropdown.value =
                                        newValue as int;
                                    //problemController.update();
                                  },
                                  items:
                                      problemController.problemsList.map((e) {
                                    return DropdownMenuItem(
                                      child: Text(e.title),
                                      value: e.rowId,
                                    );
                                  }).toList(),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: TextContent.ghiChu,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1,
                              ),
                            ),
                          ),
                          maxLines: 3,
                          onSaved: (val) {
                            problemController.noteProblem.value = val!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Obx(
                          () => problemController.imageList.isEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    problemController.openDialogCamera();
                                  },
                                  child: const Text(
                                    TextContent.attachImage,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (problemController
                                                .imageList.length ==
                                            3) {
                                          TextContent.getXSnackBar('',
                                              'Tối đa đính kèm 3 hình.', true);
                                        } else {
                                          problemController.openDialogCamera();
                                        }
                                      },
                                      child: const Text('Thêm hình'),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            problemController.imageList.length,
                                        cacheExtent: 10,
                                        key: UniqueKey(),
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Badge(
                                            badgeColor: Colors.white,
                                            badgeContent: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: IconButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                onPressed: () {
                                                  problemController.imageList
                                                      .removeAt(index);
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  size: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            child: Image.file(
                                              File(problemController
                                                  .imageList[index].path),
                                              fit: BoxFit.fill,
                                              width: 70,
                                              height: 70,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            problemController.addProblem(
                                problemController.storeCode.value,
                                problemController.customerCode.value,
                                problemController.atmOrderReleaseId.value,
                                context);
                          },
                          child: const Text(TextContent.btnSendReport),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
