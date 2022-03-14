import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

// Models
import '../models/auth.dart';

// Service Config
import '../services/service_config.dart';

class AuthService {
  static var client = http.Client();

  static Future<Auth?> signIn(String username, String password) async {
    try {
      Map<String, dynamic> body = {
        'username': username,
        'password': password,
        'grant_type': 'password'
      };
      var url = Uri.parse('${ServiceConfig.baseUrl}/token');
      var response = await client
          .post(
            url,
            body: body,
            headers: ServiceConfig.headerFormUrlEncoded,
          )
          .timeout(
            const Duration(seconds: 15),
          );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var authData = Auth.fromJson(jsonData);
        return authData;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> changePassword(
      String username,
      String userId,
      String token,
      String oldPass,
      String newPass,
      String confirmNewPass) async {
    try {
      Map<String, dynamic> body = {
        'UserName': username,
        'Id': userId,
        'Grant_type': 'password',
        'OldPassword': oldPass,
        'NewPassword': newPass,
        'ConfirmPassword': confirmNewPass
      };
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/Account/ChangePassword'),
        body: body,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': token
        },
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> checkVersionApp() async {
    try {
      final response = await http.get(
        Uri.parse('${ServiceConfig.baseUrl}/api/CheckVersionFlutterApp'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ).timeout(
        const Duration(seconds: 15),
      );

      return response.body.toString();
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<bool> packagedInfo() async {
    try {
      var result = await PackageInfo.fromPlatform();
      String currentVersion = '"${result.version}+${result.buildNumber}"';
      String versionAppResponse = await checkVersionApp();

      // debugPrint(versionAppResponse);
      // debugPrint(currentVersion);

      if (versionAppResponse != currentVersion) {
        return false;
      }
      return true;
    }
    catch(e) {
      rethrow;
    }
  }
}
