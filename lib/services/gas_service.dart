import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '../services/service_config.dart';
import 'package:http/http.dart' as http;

// Models
import '../models/gas_limit.dart';
import '../models/gas_ticket.dart';
import '../models/gas_station.dart';

class GasService {

  static Future<GasLimit?> fetchGasLimit(String driverId) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/ABA_GasTicket_GetPowerUnit_OilLimit'),
        body: json.encode({
          'driverId': driverId,
        }),
        headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataObject = GasLimit.fromJson(jsonData);
        return dataObject;
      }
      else {
        return null;
      }

    }
    catch (e) {
      rethrow;
    }
  }

  static Future<int> sendRequestGas(String driverCreatedBy, String driverId, String powerUnit, String appMessage) async {
    try {
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/ABA_STAndroid_DistributionOrderInsert'),
          body: json.encode({
            'driverCreatedBy': driverCreatedBy,
            'driverId': driverId,
            'powerUnit': powerUnit,
            'appMessage': appMessage
          }),
          headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 204) {
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

  static Future<List<GasTicket>?> fetchGasTicket(String driverId) async {
    try {
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/ABA_GasTicketByDriverId'),
          body: json.encode({
            'driverId': driverId,
          }),
          headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => GasTicket.fromJson(item))
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

  static Future<List<GasStation>?> fetchGasStation(String driverId) async {
    try {
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/ABA_GasStation_GasList'),
          body: json.encode({
            'driverId': driverId,
          }),
          headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint('${ServiceConfig.baseUrl}/api/ABA_GasStation_GasList');
      // debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => GasStation.fromJson(item))
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

  static Future<int> uploadImage(String token, XFile image, int id, String atmShipmentId, String type) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse('${ServiceConfig.baseUrl}/api/attachment5/uploadfile/ID/ATMBuyshipment/DocumentType/?ID=$id&ATMBuyshipment=$atmShipmentId&DocumentType=$type');

      // create multipart request
      var request = http.MultipartRequest("POST", url);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": token
      };

      // multipart that takes file
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(image.path));

      // add file to multipart
      request.files.add(multipartFile);

      request.headers.addAll(headers);

      // send
      var response = await request.send().timeout(
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

  static Future<int> updateGasRequest(String ticketId, int gasStationId, double lat, double lng, int odoCurrent, double actualQty, double unitPrice, String appConfirmBy, double appAmount) async {
    try {
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/ABA_STAndroid_DistributionOrderUpdate'),
          body: json.encode({
            'ticketId': ticketId,
            'gasStationId': gasStationId,
            'currentLat': lat,
            'currentLng': lng,
            'odoCurrent': odoCurrent,
            'actualQty': actualQty,
            'unitPrice': unitPrice,
            'appConfirmBy': appConfirmBy,
            'appAmount': appAmount
          }),
          headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint(gasStationId.toString());
      // debugPrint(response.statusCode.toString());

      if (response.statusCode == 204) {
        return 1;
      }
      else {
        return 0;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<GasTicket>?> fetchGasTicketHistory(String viewByDate, String driverId) async {
    try {
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/ABA_gasticket_history'),
          body: json.encode({
            'viewbyDate': viewByDate,
            'driverCreatedBy': driverId
          }),
          headers: ServiceConfig.headerApplicationJson
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var dataList = (jsonData as List)
            .map((item) => GasTicket.fromJson(item))
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