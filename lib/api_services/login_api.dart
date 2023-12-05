import 'dart:convert';
import 'package:http/http.dart' as http;

 class LoginApi {
  static const String loginUrl = 'https://api.flexinfosys.com/api/Token/Login';

  Future<Map<String, dynamic>?> loginUser(String userName, String password) async {
    try {
      final uri = Uri.parse(loginUrl);

      final headers = {
        'Content-Type': 'application/json',
      };

      final requestBody = {
        'USER_NAME': userName,
        'USER_PASSWORD': password,
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('API Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during API request: $e');
      return null;
    }
  }
}
