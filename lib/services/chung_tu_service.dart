import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
import '../models/location_atm_id.dart';
import '../models/license.dart';

// Service Config
import '../services/service_config.dart';

class ChungTuService {

  static Future<List<LocationATMId>?> fetchLocationATMShipmentId(String driverId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetShipmentId'),
        body: json.encode({
          'MaNhanVien': driverId,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => LocationATMId.fromJson(item))
            .toList();
        return dataList;
      }
      else {
        return null;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<String> createNewLicense(String token, String atmShipmentId, String customer, String startTime, String driverId, String dateOfFiling, String reason, String fullName, String region, String site) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/latelicenses/addnewlatelicenses'),
        body: json.encode({
          'ATMShipmentID': atmShipmentId,
          'Customer': customer,
          'StartTime': startTime,
          'DriverID': driverId,
          'DateOfFiling': dateOfFiling,
          'Reason': reason,
          'FullName': fullName,
          'Region': region,
          'Site': site
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as String;

        if (jsonData.contains("Thành công")) {
          return 'Gửi thành công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return 'Error API';
      }

    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<License>?> fetchLicenseList(String token, String driverId) async {
    try {
      final response = await http.get(
        Uri.parse('${ServiceConfig.baseUrl}/api/latelicenses/getlatelicenses/$driverId'),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => License.fromJson(item))
            .toList();
        return dataList;
      }
      else {
        return null;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<String> editLicense(String token, int id, String reason, String dateOfFiling) async {
    try {

      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/latelicenses/editlatelicenses'),
        body: json.encode({
          'Id': id,
          'Reason': reason,
          'DateOfFiling': dateOfFiling
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as String;

        //debugPrint(jsonData);

        if (jsonData.contains("Sửa Thành Công!")) {
          return 'Sửa Thành Công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return 'Error API';
      }

    }
    catch (e) {
      rethrow;
    }
  }

  static Future<String> deleteLicense(String token, int id) async {
    try {

      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/latelicenses/removelatelicenses'),
        body: json.encode({
          'Id': id
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as String;

        if (jsonData.contains("Xóa Thành Công!")) {
          return 'Xóa Thành Công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return 'Error API';
      }

    }
    catch (e) {
      rethrow;
    }
  }
}