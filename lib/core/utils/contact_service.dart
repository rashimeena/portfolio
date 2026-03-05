import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  static const String _endpoint =
      'https://formspree.io/f/xvzbpbaj'; // formspree URL

  static Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'message': message,
      }),
    );

    return response.statusCode == 200;
  }
}
