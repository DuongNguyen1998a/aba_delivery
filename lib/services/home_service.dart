import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

// Models
import '../models/shipment.dart';
import '../models/shipment_stop.dart';
import '../models/personal_contact.dart';
import '../models/phieu_giao_hang.dart';

// Service Config
import '../services/service_config.dart';

class HomeService {
  static String baseUrl = 'https://api-delivery.aba.com.vn:44567';
  static var client = http.Client();

  static Future<List<Shipment>?> fetchCurrentShipment(
      String driverId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/GetShipment'),
        body: json.encode({
          'Driver_Id': driverId,
          'FromDate': '',
          'ToDate': '',
          'Status': 'CURRENT'
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var currentShipments = (jsonData as List)
            .map((shipment) => Shipment.fromJson(shipment))
            .toList();
        return currentShipments;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ShipmentStop>?> fetchShipmentStops(String driverId,
      String atmShipmentId, DateTime date, String token) async {
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
        var shipmentStops = (jsonData as List)
            .map((stop) => ShipmentStop.fromJson(stop))
            .toList();
        return shipmentStops;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> updatePickupDepot(String atmShipmentId, String status,
      String token, String lat, String lng) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/UpdateGioRoiKhoVCM'),
        body: json.encode({
          'ATM_SHIPMENT_ID': atmShipmentId,
          'LAT': lat,
          'LNG': lng,
          'Status': status,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body) == '1') {
          return 1;
        } else {
          return 0;
        }
      }
      return -1;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> updateDaToi(String atmShipmentId, String storeCode,
      String atmOrderReleaseId, String token, String lat, String lng) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/UpdateArrivedTime'),
        body: json.encode({
          'ATM_SHIPMENT_ID': atmShipmentId,
          'StoreCode': storeCode,
          'LAT': lat,
          'LNG': lng,
          'orderrelease_id': atmOrderReleaseId,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body) == 1) {
          return 1;
        } else if (json.decode(response.body) > 1) {
          return 2;
        } else {
          return 0;
        }
      }
      return -1;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> updateContact(
      String atmOrderReleaseId, String phone, String personName) async {
    try {
      Map<String, dynamic> body = {
        'ATMOrderReleaseID': atmOrderReleaseId,
        'Phone': phone,
        'PersonName': personName
      };
      final response = await http.post(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/STUpdatePersonContactToBuyShipmentStop'),
          body: body,
          headers: ServiceConfig.headerFormUrlEncoded).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint(response.statusCode.toString());

      if (response.statusCode == 204) {
        return 'Ok';
      } else {
        return 'Fail';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PersonalContact>> fetchPersonalContact(
      String locationGid, String customerCode) async {
    try {
      Map<String, dynamic> body = {
        'LocationGID': locationGid,
        'CustomerCode': customerCode,
        'Phone': ''
      };
      final response = await http.post(
          Uri.parse('${ServiceConfig.baseUrl}/api/STLoadLocationPersonContact'),
          body: body,
          headers: ServiceConfig.headerFormUrlEncoded).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var personalContacts = (jsonData as List)
            .map((stop) => PersonalContact.fromJson(stop))
            .toList();
        return personalContacts;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<PhieuGiaoHang>?> fetchPhieuGiaoHang(
      String storeCode, String date, String customerCode, String token) async {
    try {
      final response = await http.post(
          Uri.parse(
              '${ServiceConfig.baseUrl}/api/PhieuGiaoHang/getlist/$storeCode/$date/$customerCode'),
          headers: ServiceConfig.headerApplicationJsonHasToken(token)).timeout(
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

  static Future<String> deliveryHub(
      String storeCode,
      String username,
      String lat,
      String lng,
      String deliveryDate,
      String customer,
      String storeCodeNhanGium,
      String reasonNhanGium,
      String atmShipmentId,
      String atmOrderReleaseId,
      String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/UpdateStateHubDriver'),
        body: json.encode({
          'Store_Code': storeCode,
          'Delivery_Date': deliveryDate,
          'KhachHang': customer,
          'Username': username,
          'Lat': lat,
          'Lng': lng,
          'CHNhanDum': storeCodeNhanGium,
          'LyDoNhanDum': reasonNhanGium,
          'Atm_Shipment_Id': atmShipmentId,
          'orderrelease_id': atmOrderReleaseId,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint('Status code: ${response.statusCode.toString()}');
      // debugPrint('Response: ${response.body.toString()}');
      // debugPrint('Current Lat: $lat, Current Lng: $lng}');

      if (response.statusCode == 200) {
        return 'Ok';
      } else {
        return 'Failed';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> updateStateStopDriver(
      String token,
      String storeCode,
      String deliveryDate,
      String customer,
      String atmShipmentId,
      int deficient,
      bool enough,
      int broken,
      int redisual,
      int badTemp,
      int realNumDelivered,
      String totalWeight,
      String lat,
      String lng,
      String atmOrderReleaseId,
      String deliveredBy,
      int totalCartonMasan,
      int trayFromNVGN) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/StateStopDriver'),
        body: json.encode({
          'Store_Code': storeCode,
          'Delivery_Date': deliveryDate,
          'KhachHang': customer,
          'Atm_Shipment_Id': atmShipmentId,
          'Deficient': deficient,
          'Enough': enough,
          'Broken': broken,
          'Residual': redisual,
          'Bad_Temperature': badTemp,
          'Real_Num_Delivered': realNumDelivered,
          'TotalWeight': totalWeight,
          'LatApp': lat,
          'LngApp': lng,
          'orderrelease_id': atmOrderReleaseId,
          'DeliveredBy': deliveredBy,
          'TotalCartonMasan': totalCartonMasan,
          'TrayFromNVGN': trayFromNVGN
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      String result = '';

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['result'];
        result = jsonData.toString();
        return 'Success: $result';
      } else {
        return 'Failed: $result';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> uploadImageChupHinhGiaoHang(
      String token,
      String storeCode,
      XFile image,
      String deliveryDate,
      String username,
      String customer,
      String note,
      String type) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse(
          '${ServiceConfig.baseUrl}/api/attachment3/uploadfile/Store_Code/Delivery_Date/NguoiTao/KhachHang/Note/Type?Store_Code=$storeCode&Delivery_Date=$deliveryDate&NguoiTao=$username&KhachHang=$customer&Note=$note&Type=$type');

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
      } else {
        return 0;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> addADCADShipment(String token, String atmShipmentId,
      String startTime, String driverName, String driverId) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/adcadshipment/addnew'),
        body: json.encode({
          'ATMShipmentId': atmShipmentId,
          'StartTime': startTime,
          'DriverName': driverName,
          'DriverID': driverId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      //debugPrint(json.decode(response.body)['id'].toString());

      if (response.statusCode == 200) {
        if (json.decode(response.body)['id'] > -1) {
          return json.decode(response.body)['id'];
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> addADCADImage(String token, int id, XFile image) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse(
          '${ServiceConfig.baseUrl}/api/attachmentshipment/addfile/ID?ID=$id');

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
      } else {
        return 0;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<int> updateADCADStateShipment(String atmShipmentId, String driverId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/AcceptAndAssign'),
        body: json.encode({
          'Atm_Shipment_id': atmShipmentId,
          'Status': 'ADCAD',
          'Driver_GID': driverId,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

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
}
