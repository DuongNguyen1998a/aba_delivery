import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
import '../models/feedback.dart';
import '../models/shipment_order_payment.dart';

// Service Config
import '../services/service_config.dart';

class GopYService {
  static var client = http.Client();

  static Future<List<Feedback>?> fetchFeedback(String token, String driverId) async {
    try {
      final response = await http.get(
        Uri.parse('${ServiceConfig.baseUrl}/api/feedback/getfb/$driverId'),
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var fbList = (jsonData as List)
            .map((fb) => Feedback.fromJson(fb))
            .toList();
        return fbList;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<int?> addFeedback(String token, String driverName, String driverId, String atmShipmentId, String type, String content, String title) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/feedback/addnewfb'),
        body: json.encode({
          'DriverName': driverName,
          'DriverID': driverId,
          'ATMShipmentID': atmShipmentId,
          'Type': type,
          'Content': content,
          'Title': title,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<List<ShipmentOrderPayment>?> fetchShipmentOrderPayment(String token, String driverId) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetShipmentIDFB'),
        body: json.encode({
          'EmployeeID': driverId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var list = (jsonData as List)
            .map((item) => ShipmentOrderPayment.fromJson(item))
            .toList();
        return list;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }
}