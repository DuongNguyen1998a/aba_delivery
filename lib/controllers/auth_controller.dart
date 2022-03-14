import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// App Routes
import '../constants/app_routes.dart';

// Text Content
import '../constants/text_content.dart';

// Models
import '../models/auth.dart';

// Services
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> changePasswordKey = GlobalKey();
  final newPassTextController = TextEditingController();
  final GlobalKey<ScaffoldState> modelScaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = false.obs;
  var isHidePassword = true.obs;
  var auth = <Auth>{}.obs;
  var username = ''.obs;
  var password = ''.obs;

  // Change Password
  var isHideOldPassword = true.obs;
  var isHideNewPassword = true.obs;
  var isHideConfirmNewPassword = true.obs;
  var oldPassword = ''.obs;
  var newPassword = ''.obs;
  var confirmNewPassword = ''.obs;

  // Change Password

  @override
  void onInit() {
    //reSignedIn();
    super.onInit();
  }

  void showPassword() {
    if (isHidePassword.isTrue) {
      isHidePassword.value = false;
    } else {
      isHidePassword.value = true;
    }
  }

  void showChangePassword(int key) {
    if (key == 1) {
      isHideOldPassword.value = !isHideOldPassword.value;
    } else if (key == 2) {
      isHideNewPassword.value = !isHideNewPassword.value;
    } else {
      isHideConfirmNewPassword.value = !isHideConfirmNewPassword.value;
    }
  }

  String? validateUsername(String username) {
    if (username.isEmpty || username.toString().trim() == '') {
      return TextContent.validateUsername;
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty || password.toString().trim() == '') {
      return TextContent.validatePassword;
    }
    return null;
  }

  void _showSnackBar(BuildContext context, String content) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
          textColor: Colors.orangeAccent,
          label: 'Ok',
          onPressed: () {
            // dismiss SnackBar
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> signIn(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      formKey.currentState!.save();
      isLoading(true);
      var authResponse =
          await AuthService.signIn(username.value, password.value);

      if (authResponse != null) {
        auth.assign(authResponse);
        // save data into shared preferences
        final prefs = await SharedPreferences.getInstance();
        final authData = json.encode({
          'token': '${authResponse.tokenType} ${authResponse.accessToken}',
          'username': username.value,
          'password': password.value,
        });
        prefs.setString('Auth', authData);
        Get.offNamed(AppRoutes.homeLink);
        // save data into shared preferences
      } else {
        _showSnackBar(context, TextContent.validateSignIn);
      }
      isLoading(false);
    } on SocketException catch (_) {
      _showSnackBar(context, TextContent.internetError);
      isLoading(false);
    } catch (e) {
      _showSnackBar(context, e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<bool> reSignedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('Auth')) {
        return false;
      } else {
        final extractedData = json.decode(prefs.getString('Auth') ?? '');
        final username = extractedData['username'];
        final password = extractedData['password'];
        if (extractedData['token'] != null || extractedData['token'] != '') {
          var authResponse = await AuthService.signIn(username, password);
          if (authResponse != null) {
            auth.assign(authResponse);
            final authData = json.encode({
              'token': '${authResponse.tokenType} ${authResponse.accessToken}',
              'username': username,
              'password': password,
            });
            prefs.setString('Auth', authData);
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    Get.offNamed(AppRoutes.authLink);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  // Change Password
  String? validateOldPassword(String oldPassword) {
    if (oldPassword.isEmpty || oldPassword.toString().trim() == '') {
      return TextContent.validateOldPassword;
    }
    return null;
  }

  String? validateNewPassword(String newPassword) {
    if (newPassword.isEmpty || newPassword.toString().trim() == '') {
      return TextContent.validateNewPassword;
    }
    return null;
  }

  String? validateConfirmNewPassword(String confirmNewPassword) {
    if (confirmNewPassword.isEmpty ||
        confirmNewPassword.toString().trim() == '') {
      return TextContent.validateConfirmNewPassword;
    } else if (confirmNewPassword.toString().trim() !=
        newPassTextController.text.toString().trim()) {
      return TextContent.validateConfirmNewPassword1;
    }
    return null;
  }

  Future<void> changePassword(BuildContext context) async {
    try {
      if (!changePasswordKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // close keyboard
      FocusScope.of(context).unfocus();
      // saved form
      changePasswordKey.currentState!.save();
      isLoading(true);
      var resultResponse = await AuthService.changePassword(
        auth.single.userName,
        auth.single.userId,
        'Bearer ${auth.single.accessToken}',
        oldPassword.value,
        newPassword.value,
        confirmNewPassword.value,
      );

      if (resultResponse) {
        oldPassword('');
        newPassword('');
        confirmNewPassword('');
        isHideOldPassword(true);
        isHideNewPassword(true);
        isHideConfirmNewPassword(true);
        newPassTextController.text = '';
        signOut();
      } else {
        TextContent.getXSnackBar('', TextContent.errorResponseFail, true);
      }
    } on SocketException catch (_) {
      TextContent.getXSnackBar(
          TextContent.internetErrorTitle, TextContent.internetError, true);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
// Change Password

  Future<bool> checkVersionApp() async {
    try {
      var response = await AuthService.packagedInfo();

      return response;
    }
    catch (e) {
      rethrow;
    }
  }

  Future<String> getVersionApp() async {
    try {
      var response = await AuthService.checkVersionApp();

      return response;
    }
    catch (e) {
      rethrow;
    }
  }

}
