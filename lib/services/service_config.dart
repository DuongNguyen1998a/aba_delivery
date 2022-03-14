class ServiceConfig {
  static String baseUrl = 'https://apideli.aba.com.vn:44567';

  static Map<String, String> headerFormUrlEncoded = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static Map<String, String> headerFormUrlEncodedHasToken(String token) {
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
  }

  static Map<String, String> headerApplicationJson = {
    'Content-Type': 'application/json'
  };

  static Map<String, String> headerApplicationJsonHasToken(String token) {
    return {'Content-Type': 'application/json', 'Authorization': token};
  }

  static Map<String, String> onlyAuthorization(String token) {
    return {'Authorization': token};
  }
}
