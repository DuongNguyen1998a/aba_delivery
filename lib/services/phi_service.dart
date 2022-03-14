import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

// Models
import '../models/de_nghi_tam_ung.dart';
import '../models/de_nghi_thanh_toan.dart';
import '../models/de_nghi_thanh_toan_detail.dart';
import '../models/expense_attachment.dart';
import '../models/fee_type.dart';
import '../models/result_image.dart';
import '../models/shipment_advance_payment.dart';

// Service Config
import '../services/service_config.dart';

class PhiService {
  static var client = http.Client();

  static Future<List<DeNghiTamUng>?> fetchDeNghiTamUng(
      String month, String year, String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetExpensesAmount');
      var response = await client.post(
        url,
        body:
            json.encode({'Month': month, 'Year': year, 'MaNhanVien': driverId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var tamUngList = (jsonData as List)
            .map((tamUng) => DeNghiTamUng.fromJson(tamUng))
            .toList();
        return tamUngList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<DeNghiThanhToan>?> fetchDeNghiThanhToan(
      String month, String year, String driverId, String token) async {
    try {
      var url =
          Uri.parse('${ServiceConfig.baseUrl}/api/GetShipmentOrderPayment');
      var response = await client.post(
        url,
        body:
            json.encode({'Month': month, 'Year': year, 'EmployeeID': driverId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var thanhToanList = (jsonData as List)
            .map((tt) => DeNghiThanhToan.fromJson(tt))
            .toList();
        return thanhToanList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<DeNghiThanhToanDetail>?> fetchDeNghiThanhToanDetail(
      String atmShipmentId, token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetDetailOP');
      var response = await client.post(
        url,
        body: json.encode({'ATMShipmentID': atmShipmentId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var thanhToanDetailList = (jsonData as List)
            .map((ttDetail) => DeNghiThanhToanDetail.fromJson(ttDetail))
            .toList();
        return thanhToanDetailList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ExpenseAttachment>?> fetchImages(
      int id, String token) async {
    try {
      //debugPrint(id.toString());
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetExpensesAttachment');
      var response = await client.post(
        url,
        body: json.encode({'ID': id}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var expenseImageList = (jsonData as List)
            .map((image) => ExpenseAttachment.fromJson(image))
            .toList();
        return expenseImageList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<FeeType>?> fetchFeeType(String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetAdvanceFee');
      var response = await client.get(
        url,
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var feeTypeList =
            (jsonData as List).map((fee) => FeeType.fromJson(fee)).toList();
        return feeTypeList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ShipmentAdvancePayment>?> fetchShipmentAdvancePayment(
      String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetInfoAdvanceFee');
      var response = await client.post(
        url,
        body: json.encode({'DriverGID': driverId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var shipmentAdvancePaymentList = (jsonData as List)
            .map((item) => ShipmentAdvancePayment.fromJson(item))
            .toList();
        return shipmentAdvancePaymentList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int?> sendTamUng(
    String token,
    String atmShipmentId,
    String otmShipmentId,
    String powerUnit,
    String driverId,
    String driverName,
    String department,
    String customer,
    String invNumber,
    String advPaymentType,
    String description,
    String amount,
    String city,
    String startTime,
  ) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/addnew');
      var response = await client.post(
        url,
        body: json.encode({
          'ATMShipmentID': atmShipmentId,
          'OTMShipmentID': otmShipmentId,
          'PowerUnit': powerUnit,
          'EmployeeID': driverId,
          'EmployeeName': driverName,
          'Department': department,
          'Customer': customer,
          'InvoiceNumber': invNumber,
          'AdvancePaymentType': advPaymentType,
          'Description': description,
          'Amount': amount,
          'City': city,
          'StartTime': startTime,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      //debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['aPR_Expenses'];
        if (jsonData['id'] == 0) {
          return 0;
        } else if (jsonData['id'] > 0) {
          return 1;
        } else {
          return -1;
        }
      }
      return -1;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int?> updateTamUng(String token, String atmShipmentId,
      int amount, String description, String advPaymentType) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/editexpenses');
      var response = await client.post(
        url,
        body: json.encode({
          'ID': atmShipmentId,
          'Amount': amount,
          'Description': description,
          'AdvancePaymentType': advPaymentType,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['state'];
        debugPrint(jsonData);
        if (jsonData.contains('Cập Nhật Thành Công!')) {
          return 1;
        }
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<int?> deleteTamUng(
      String token, int id, String advPaymentType) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/removeexpenses');
      var response = await client.post(
        url,
        body: json.encode({
          'ID': id,
          'AdvancePaymentType': advPaymentType,
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['state'];
        debugPrint(jsonData);
        if (jsonData.contains('Xóa Thành Công!')) {
          return 1;
        }
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ResultImage>?> addImageTamUng(int id, String atmShipmentId,
      String documentType, XFile mFile, String token) async {
    try {
      // open a bytestream
      var stream = http.ByteStream(DelegatingStream.typed(mFile.openRead()));

      // get file length
      var length = await mFile.length();

      var url = Uri.parse(
          '${ServiceConfig.baseUrl}/api/attachment5/addfile/ID/ATMBuyshipment/DocumentType/?ID=$id&ATMBuyshipment=$atmShipmentId&DocumentType=$documentType');

      // create multipart request
      var request = http.MultipartRequest("POST", url);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": token
      };

      // multipart that takes file
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(mFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      request.headers.addAll(headers);

      // send
     await request.send().timeout(
       const Duration(seconds: 15),
     );


    } catch (e) {
      rethrow;
    }
    return null;
  }

  static Future<String?> deleteImageTamUng(
      String token, int id, String attachName, String advPaymentType) async {
    try {
      var url =
          Uri.parse('${ServiceConfig.baseUrl}/api/apr/removeexpensesfile');
      var response = await client.post(
        url,
        body: json.encode({
          'ID': id,
          'AttachName': attachName,
          'DocumentType': advPaymentType
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['state'];
        if (jsonData.toString().contains('Xóa Thành Công!')) {
          return 'Xóa thành công.';
        } else {
          return jsonData;
        }
      } else {
        return 'Error';
      }
    } catch (e) {
      rethrow;
    }
  }
}
