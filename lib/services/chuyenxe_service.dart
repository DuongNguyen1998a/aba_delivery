import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Models
import '../models/shipment.dart';
import '../models/shipment_stop.dart';

// Service Config
import '../services/service_config.dart';

class ChuyenXeService {
  static var client = http.Client();

  static Future<List<Shipment>?> fetchShipmentByMode(int key, String driverId,
      String fromDate, String toDate, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetShipment'),
        body: json.encode({
          'Driver_Id': driverId,
          'FromDate': fromDate + ' 00:00:00',
          'ToDate': toDate + ' 23:59:59',
          'Status': key == 1 ? 'ASSIGNED' : 'ACCEPTED'
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var shipmentList = (jsonData as List)
            .map((shipment) => Shipment.fromJson(shipment))
            .toList();
        return shipmentList;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> deniedShipment(
      String atmShipmentId,
      DateTime deliveryDate,
      String routeNo,
      String reason,
      String token,
      String driverId,
      String driverName) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/DeniedTrip'),
        body: json.encode({
          'ATMShipmentID': atmShipmentId,
          'TripDate': DateFormat('yyyy-MM-dd').format(deliveryDate),
          'RouteNo': routeNo,
          'DriverGID': driverId,
          'DriverName': driverName,
          'Reason': reason
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body) == 1) {
          return 1;
        } else {
          return 0;
        }
      }
      return 0;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> acceptedShipment(
      String atmShipmentId, String driverId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/AcceptAndAssign'),
        body: json.encode({
          'Atm_Shipment_id': atmShipmentId,
          'Status': 'ACCEPTED',
          'Driver_GID': driverId,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['result'] == 1) {
          return 1;
        }
        else {
          return 0;
        }
      }
      return 0;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> startShipment(String atmShipmentId, String driverId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/CurrentShipment'),
        body: json.encode(
            {'Atm_Shipment_id': atmShipmentId, 'Driver_GID': driverId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['result'] == 1) {
          return 1;
        }
        else {
          return 0;
        }
      }
      else {
        return -1;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<ShipmentStop>?> fetchShipmentStops(String driverId, String atmShipmentId, DateTime date, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetStopShipment2'),
        body: json.encode({
          'MaNhanVien': driverId,
          'ATM_Shipment_Id': atmShipmentId,
          'Delivery_Date': DateFormat('yyyy-MM-dd').format(date)
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var shipmentStops = (jsonData as List).map((stop) => ShipmentStop.fromJson(stop)).toList();
        return shipmentStops;
      }
      return null;
    }
    catch (e) {
      rethrow;
    }
  }
}
