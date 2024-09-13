import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      'https://your-api-url.com/api/storagecalculator'; // Replace with your API URL

  Future<Map<String, dynamic>> calculateStorageCharges(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to calculate storage charges');
    }
  }
}
