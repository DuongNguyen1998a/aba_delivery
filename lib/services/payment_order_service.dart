import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

// Models
import '../models/de_nghi_thanh_toan.dart';
import '../models/de_nghi_thanh_toan_detail.dart';
import '../models/expense_attachment.dart';
import '../models/shipment_order_payment.dart';
import '../models/payment_order_fee_type.dart';
import '../models/detail_order_payment.dart';
// Service Config
import 'service_config.dart';
// Text Content
import '../constants/text_content.dart';

class PaymentOrderService {
  static var client = http.Client();

  static Future<List<DeNghiThanhToan>?> fetchPaymentOrder(String month, String year, String driverId, String token) async {
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
        var paymentOrderList = (jsonData as List)
            .map((tt) => DeNghiThanhToan.fromJson(tt))
            .toList();
        return paymentOrderList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<DeNghiThanhToanDetail>?> fetchPaymentOrderDetail(String atmShipmentId, token) async {
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
        var paymentOrderDetailList = (jsonData as List)
            .map((ttDetail) => DeNghiThanhToanDetail.fromJson(ttDetail))
            .toList();
        return paymentOrderDetailList;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ExpenseAttachment>?> fetchPaymentOrderDetailImage(int id, String token) async {
    try {
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

  static Future<List<ShipmentOrderPayment>?> fetchShipmentOrderPaymentForAddAction(String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetShipmentIDOP');
      var response = await client.post(
        url,
        body: json.encode({'EmployeeID': driverId}),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var poShipmentList = (jsonData as List)
            .map((po) => ShipmentOrderPayment.fromJson(po))
            .toList();
        return poShipmentList;
      }
      else {
        return null;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<List<PaymentOrderFeeType>?> fetchPoFeeType(String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/loaiphi');
      var response = await client.post(
        url,
        headers: ServiceConfig.onlyAuthorization(token),
      ).timeout(
        const Duration(seconds: 15),
      );


      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var poFeeType = (jsonData as List)
            .map((po) => PaymentOrderFeeType.fromJson(po))
            .toList();
        return poFeeType;
      }
      else {
        return null;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<List<DetailOrderPayment>?> sendPaymentOrder(List<DetailOrderPayment> list, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/addnewop');
      var response = await client.put(
        url,
        body: json.encode(list),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        if (json.encode(response.body).isNotEmpty) {
          if (json.decode(response.body)[0]['id'] > 0) {
            var jsonData = json.decode(response.body);
            var dataList = (jsonData as List)
                .map((po) => DetailOrderPayment.fromJson(po))
                .toList();
            return dataList;
          }
          else {
            return null;
          }
        }
        return null;
      }
      return null;
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<void> addImagePaymentOrder(String token, int id, String atmShipmentId, String documentType, XFile image) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse(
          '${ServiceConfig.baseUrl}/api/attachment5/uploadfile/ID/ATMBuyshipment/DocumentType/?ID=$id&ATMBuyshipment=$atmShipmentId&DocumentType=$documentType');

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
      await request.send().timeout(
        const Duration(seconds: 15),
      );
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<String?> deletePaymentOrder(String token, int id) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/removeop');
      var response = await client.post(
        url,
        body: json.encode({
          'ID': id
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['state'] as String;
        if (jsonData.contains('Xóa Thành Công!')) {
          return 'Xóa Thành Công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return TextContent.errorResponseFail;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<String?> editPaymentOrder(int id, int amount, String description, String advPaymentType, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/editop');
      var response = await client.post(
        url,
        body: json.encode({
          'ID': id,
          'Amount': amount,
          'Description': description,
          'AdvancePaymentType': advPaymentType
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['state'] as String;
        if (jsonData.contains('Cập Nhật Thành Công!')) {
          return 'Cập Nhật Thành Công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return TextContent.errorResponseFail;
      }
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<String?> deleteImagePaymentOrder(int id, String attachName, String advPaymentType, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/apr/removeexpensesfile');
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
        var jsonData = json.decode(response.body)['state'] as String;
        if (jsonData.contains('Xóa Thành Công!')) {
          return 'Xóa Thành Công!';
        }
        else {
          return jsonData;
        }
      }
      else {
        return TextContent.errorResponseFail;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<int> addImagePaymentOrderDetail(int id, String atmShipmentId, String token, XFile image) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse('${ServiceConfig.baseUrl}/api/attachment5/addfileop/ID/ATMBuyshipment/?ID=$id&ATMBuyshipment=$atmShipmentId');

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
    catch(e) {
      rethrow;
    }
  }
}