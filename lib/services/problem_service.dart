import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// Models
import '../models/problem.dart';
import '../models/problem_response.dart';
// Service Config
import 'service_config.dart';

class ProblemService {
  static var client = http.Client();

  static Future<List<Problem>?> fetchProblemList(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ServiceConfig.baseUrl}/api/problem/gets'),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['problems'];
        var problemList = (jsonData as List)
            .map((problem) => Problem.fromJson(problem))
            .toList();
        return problemList;
      }
      return null;
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<ProblemResponse?> addProblem(int problemId, String storeCode, String note, String customer, String atmOrderReleaseId, String createdBy, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ServiceConfig.baseUrl}/api/report/addnew'),
        body: json.encode({
          'ProblemId': problemId,
          'Store_Code': storeCode,
          'Note': note,
          'KhachHang': customer,
          'orderrelease_id': atmOrderReleaseId,
          'CreatedBy': createdBy
        }),
        headers: ServiceConfig.headerFormUrlEncodedHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      // debugPrint('Response nè: ${response.body.toString()}');
      // debugPrint('Response StatusCode: ${response.statusCode.toString()}');
      // debugPrint('$problemId, $storeCode, $note, $customer, $atmOrderReleaseId, $createdBy');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var responseData = ProblemResponse.fromJson(jsonData);
        return responseData;
      }
      else {
        return null;
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<int> addImageProblem(XFile image, String token, int reportId) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));

      // get file length
      var length = await image.length();

      var url = Uri.parse(
          '${ServiceConfig.baseUrl}api/attachment/uploadfile/ReportId/?ReportId=$reportId');

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
      final response = await request.send().timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
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
}