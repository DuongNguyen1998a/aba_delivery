import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
import '../models/giao_bu.dart';
import '../models/biker_customer.dart';
import '../models/giao_bu_detail.dart';

// Service Config
import '../services/service_config.dart';

class GiaoBuService {

  static Future<List<GiaoBu>?> fetchGiaoBuList(String token, String deliveryDate, String customer) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetStoreGiaoBu'),
        body: json.encode({
          'Delivery_Date': deliveryDate,
          'KhachHang': customer
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => GiaoBu.fromJson(item))
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

  static Future<List<BikerCustomer>?> fetchBikerCustomer(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetBikerCustomer'),
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => BikerCustomer.fromJson(item))
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

  static Future<List<GiaoBuDetail>?> fetchItemDetailGiaoBu(String token, String deliveryDate, String storeCode, String customer, String atmShipmentId) async {
    try {

      //debugPrint('$deliveryDate - $storeCode, $customer, $atmShipmentId');

      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetItemStoreGiaoBu'),
        body: json.encode({
          'Delivery_Date': '2021/05/01',
          'Store_Code': storeCode,
          'KhachHang': customer,
          'ATM_SHIPMENT_ID':atmShipmentId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      //debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => GiaoBuDetail.fromJson(item))
            .toList();
        //debugPrint(dataList.toList().toString());

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

  static Future<String?> updateQtyGiaoBu(String token, String rowId, int qtyGiaoBu, String createdBy) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/UpdateGiaoBu'),
        body: json.encode({
          'RowId': rowId,
          'GiaoBu': qtyGiaoBu,
          'CreatedBy_GiaoBu': createdBy
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return jsonData;
      }
      else {
        return 'Failed';
      }
    }
    catch (e) {
      rethrow;
    }
  }
}