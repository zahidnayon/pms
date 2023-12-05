import 'dart:convert';
import 'package:http/http.dart' as http;

class UnidApi {
  static Future<List<dynamic>> fetchUnitData() async {
    try {
      final response =
      await http.get(Uri.parse('https://api.flexinfosys.com/api/unit'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
