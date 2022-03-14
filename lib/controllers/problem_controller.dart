import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// Text Content
import '../constants/app_routes.dart';
import '../constants/text_content.dart';

// Models
import '../models/problem.dart';
import '../models/problem_response.dart';

// Problem Service
import '../services/problem_service.dart';

// Controllers
import 'auth_controller.dart';

class ProblemController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var selectedDropdown = 0.obs;
  var problemsList = <Problem>[].obs;
  final ImagePicker imagePicker = ImagePicker();
  var imageList = <XFile>[].obs;

  // Add sự cố
  var isLoading = false.obs;
  var addProblemResult = <ProblemResponse>{}.obs;
  final GlobalKey<FormState> formKey = GlobalKey();
  var noteProblem = ''.obs;

  final arguments = Get.arguments;
  var deliveryDate = ''.obs;
  var storeCode = ''.obs;
  var storeName = ''.obs;
  var addressLine = ''.obs;
  var customerCode = ''.obs;
  var atmOrderReleaseId = ''.obs;

  @override
  void onInit() {
    if (arguments != null) {
      deliveryDate.value =
          DateFormat('dd-MM-yyyy').format(arguments[4]['deliveryDate']);
      storeCode.value = arguments[0]['storeCode'];
      storeName.value = arguments[1]['storeName'];
      addressLine.value = arguments[3]['addressLine'];
      customerCode.value = arguments[5]['customerCode'];
      atmOrderReleaseId.value = arguments[2]['atmOrderReleaseId'];
    }

    fetchProblemList()
        .then((_) => selectedDropdown.value = problemsList[0].rowId);
    super.onInit();
  }

  Future<void> fetchProblemList() async {
    try {
      var problems = await ProblemService.fetchProblemList(
          'Bearer ${authController.auth.single.accessToken}');

      if (problems != null) {
        problemsList.assignAll(problems);
      } else {
        problemsList.value = [];
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }

  void pickImage() async {
    final XFile? mPickImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );

    if (mPickImage != null) {
      imageList.add(mPickImage);
    }
  }

  void takeImage() async {
    final XFile? mTakeImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 768,
    );
    if (mTakeImage != null) {
      imageList.add(mTakeImage);
    }
  }

  void openDialogCamera() {
    Get.defaultDialog(
      title: '',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              pickImage();
              Get.back();
            },
            child: const Text('Chọn ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              takeImage();
              Get.back();
            },
            child: const Text('Chụp hình'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Future<void> addProblem(String storeCode, String customer,
      String atmOrderReleaseId, BuildContext context) async {
    try {
      if (imageList.isEmpty) {
        TextContent.getXSnackBar('', TextContent.attachImage, true);
        return;
      }

      if (!formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      formKey.currentState!.save();
      var result = await ProblemService.addProblem(
        selectedDropdown.value,
        storeCode,
        noteProblem.value,
        customer,
        atmOrderReleaseId,
        authController.auth.single.userName,
        'Bearer ${authController.auth.single.accessToken}',
      );

      if (result != null) {
        if (result.message !=
            ' is added before, please choose another store!') {
          addProblemResult.assign(result);

          if (imageList.isNotEmpty) {
            imageList.map((element) async {
              var resultAddImage = await ProblemService.addImageProblem(
                  element,
                  'Bearer ${authController.auth.single.accessToken}',
                  addProblemResult.single.id ?? 0);
              if (resultAddImage == 1) {
                TextContent.getXSnackBar('', 'Thêm hình thành công', true);
              } else {
                TextContent.getXSnackBar('', 'Thêm hình thất bại', true);
              }
            });

            TextContent.getXSnackBar('', 'Gửi báo cáo thành công.', true);
            Get.delete<ProblemController>();
            Get.toNamed(AppRoutes.homeLink);
          }
        } else {
          TextContent.getXSnackBar(
              '',
              '$storeCode đã thêm trước đó, vui lòng chọn cửa hàng khác.',
              true);
          //return;
        }
      } else {
        TextContent.getXSnackBar('',
            '$storeCode đã thêm trước đó, vui lòng chọn cửa hàng khác.', true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    }
  }
}
