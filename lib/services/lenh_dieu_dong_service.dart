import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
import '../models/dieu_dong.dart';

// Service Config
import '../services/service_config.dart';

class LenhDieuDongService {
  static var client = http.Client();

  static Future<List<DieuDong>?> fetchDieuDong(String driverId, String token) async {
    try {
      var url = Uri.parse('${ServiceConfig.baseUrl}/api/GetLenhDieuDong');
      var response = await client.post(
        url,
        body: json.encode({
          'DRIVER_GID': driverId
        }),
        headers: ServiceConfig.headerApplicationJsonHasToken(token),
      ).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var lddList = (jsonData as List)
            .map((ldd) => DieuDong.fromJson(ldd))
            .toList();
        return lddList;
      }
      else {
        return null;
      }
    }
    catch(e) {
      rethrow;
    }
  }

}