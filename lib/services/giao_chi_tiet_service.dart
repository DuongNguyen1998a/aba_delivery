import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// Models
import '../models/basket_response.dart';
import '../models/phieu_giao_hang.dart';
import '../models/item_booking.dart';
import '../models/shipment_complete.dart';
// Service Config
import 'service_config.dart';

class GiaoChiTietService {
  static var client = http.Client();

  static Future<List<PhieuGiaoHang>?> fetchPhieuGiaoHang(
      String storeCode, String date, String customerCode, String token) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/PhieuGiaoHang/getlist/$storeCode/$date/$customerCode'),
          headers: ServiceConfig.onlyAuthorization(token)).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['items'];
        var phieuGiaoHangList = (jsonData as List)
            .map((phieu) => PhieuGiaoHang.fromJson(phieu))
            .toList();
        return phieuGiaoHangList;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<BasketResponse>?> fetchQuantityBasket(
      String atmOrderReleaseId, String token) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/basket/transactiondetail/atm/$atmOrderReleaseId'),
          headers: ServiceConfig.onlyAuthorization(token)).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => BasketResponse.fromJson(item))
            .toList();
        return dataList;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> updateQuantityBasket(String token, int id,
      int qtyConfirmSendStore, int qtyConfirmReceivedStore) async {
    try {

      // debugPrint('Start Service updateQuantityBasket');
      // debugPrint('QuantityConfirmSendStore: $qtyConfirmSendStore');
      // debugPrint('QuantityConfirmReceivedStore: $qtyConfirmReceivedStore');
      // debugPrint('id: $id');


      final response = await http.post(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/basket/transactiondetail/update'),
          body: json.encode({
            'id': id,
            'QuantityConfirmSendStore': qtyConfirmSendStore,
            'QuantityConfirmReceivedStore': qtyConfirmReceivedStore,
            'DateConfirmSendReceiveStore':
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
          }),
          headers: ServiceConfig.headerApplicationJsonHasToken(token)).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint(response.statusCode.toString());
      // debugPrint(response.body.toString());
      // debugPrint(token);
      // debugPrint(json.decode(response.body)['result'].toString());
      // debugPrint('${ServiceConfig.baseUrl}/api/basket/transactiondetail/update');
      // debugPrint(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

      if (response.statusCode == 200) {
        if (json.decode(response.body)['result']) {
          //debugPrint(json.decode(response.body)['msg']);
          return 'True';
        } else {
          return 'False';
        }
      }
      return 'False';
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> updateBooking(String token, List<ItemBooking> itemList) async {
    try {
      final response = await http.put(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/PhieuGiaoHang/UpdatePGH'),
          body: json.encode(itemList),
          headers: ServiceConfig.headerApplicationJsonHasToken(token)).timeout(
        const Duration(seconds: 15),
      );

      //debugPrint('Status Code: '+response.body.toString());

      if (response.statusCode == 200) {
        return 1;
      }
      else {
        return 0;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<List<ShipmentComplete>?> shipmentCompleted(String token, String driverId, String deliveryDate, String atmShipmentId) async {
    try {
      final response = await http.post(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/ShipmentCompleted'),
          body: json.encode({
            'DriverGID': driverId,
            'DeliveryDate': deliveryDate,
            'ATMShipmentID': atmShipmentId
          }),
          headers: ServiceConfig.headerApplicationJsonHasToken(token)).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint('Status Code: '+response.statusCode.toString());
      // debugPrint(driverId);
      // debugPrint(deliveryDate);
      // debugPrint(atmShipmentId);
      // debugPrint('${ServiceConfig.baseUrl}/api/ShipmentCompleted');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => ShipmentComplete.fromJson(item))
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
}
