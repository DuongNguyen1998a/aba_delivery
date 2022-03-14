import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Text Content
import '../constants/text_content.dart';

// Controllers
import '../controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextContent.titleAuthScreen),
      ),
      body: SafeArea(
        child: Form(
          key: authController.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
                  child: Image.asset(
                    './assets/images/logo_resize.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: TextContent.username,
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    validator: (val) {
                      return authController.validateUsername(val!);
                    },
                    onSaved: (val) {
                      authController.username.value = val!;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Obx(
                      () =>
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password_outlined),
                            labelText: TextContent.password,
                            suffixIcon: IconButton(
                              onPressed: () {
                                authController.showPassword();
                              },
                              icon: authController.isHidePassword.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                          obscureText:
                          authController.isHidePassword.value ? true : false,
                          validator: (val) {
                            return authController.validatePassword(val!);
                          },
                          onSaved: (val) {
                            authController.password.value = val!;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                ),
                Obx(
                      () =>
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                          onPressed: () {
                            authController.signIn(context);
                          },
                          child: const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(18),
                          ),
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
