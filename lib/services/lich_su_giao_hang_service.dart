import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
import '../models/history.dart';
import '../models/history_detail.dart';
import '../models/history_delivery.dart';
import '../models/history_delivery_detail.dart';

// Service Config
import '../services/service_config.dart';

class LichSuGiaoHangService {
  static var client = http.Client();

  static Future<List<History>?> fetchHistorySalary(int year, int month, String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/PhieuGiaoHang/getsalary/$year/$month/$driverId');

      var response = await client.get(
        url,
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['items'];
        var historyList = (jsonData as List)
            .map((history) => History.fromJson(history))
            .toList();
        return historyList;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<HistoryDetail>?> fetchHistorySalaryDetail(String atmShipmentId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/PhieuGiaoHang/getsalarydetail/DRIVER_ID/?DRIVER_ID=$atmShipmentId');

      var response = await client.get(
        url,
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['items'];
        var historyListDetail = (jsonData as List)
            .map((history) => HistoryDetail.fromJson(history))
            .toList();
        return historyListDetail;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<HistoryDelivery>?> fetchHistoryDelivery(int month, int year, String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/HistoryDeliveryDriverNewVer');

      var response = await client.post(
        url,
        body: json.encode({
          'month': month,
          'year': year,
          'MaNhanVien': driverId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var historyDelivery = (jsonData as List)
            .map((history) => HistoryDelivery.fromJson(history))
            .toList();
        return historyDelivery;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<HistoryDeliveryDetail>?> fetchHistoryDeliveryDetail(String atmShipmentId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/HistoryStopDeliveryDriver');

      var response = await client.post(
        url,
        body: json.encode({
          'ATM_SHIPMENT_ID': atmShipmentId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var historyDeliveryDetail = (jsonData as List)
            .map((history) => HistoryDeliveryDetail.fromJson(history))
            .toList();
        return historyDeliveryDetail;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }
}