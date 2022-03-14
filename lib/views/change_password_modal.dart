import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import '../controllers/auth_controller.dart';

class ChangePasswordModal extends StatelessWidget {
  const ChangePasswordModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Form(
              key: authController.changePasswordKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu củ',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authController.showChangePassword(1);
                            },
                            icon: authController.isHideOldPassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        validator: (val) {
                          return authController.validateOldPassword(val!);
                        },
                        onSaved: (val) {
                          authController.oldPassword.value = val!;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: authController.isHideOldPassword.value ? true : false,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authController.showChangePassword(2);
                            },
                            icon: authController.isHideNewPassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        controller: authController.newPassTextController,
                        validator: (val) {
                          return authController.validateNewPassword(val!);
                        },
                        onSaved: (val) {
                          authController.newPassword.value = val!;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: authController.isHideNewPassword.value ? true : false,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Obx(
                      () => TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu mới',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authController.showChangePassword(3);
                            },
                            icon: authController.isHideConfirmNewPassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        validator: (val) {
                          return authController
                              .validateConfirmNewPassword(val!);
                        },
                        onSaved: (val) {
                          authController.confirmNewPassword.value = val!;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: authController.isHideConfirmNewPassword.value ? true : false,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => authController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    authController.changePassword(context);
                                  },
                                  child: const Text('Xác nhận'),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
