import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // Alamat backend Django untuk Flutter Web di Chrome.
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  // Token autentikasi setelah login.
  static String? token;

  // Header untuk request API.
  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Token $token',
    };
  }

  // Mengambil daftar project.
  static Future<http.Response> getProjects() async {
    return await http.get(Uri.parse('$baseUrl/projects/'), headers: headers);
  }

  // Mengambil daftar experience.
  static Future<http.Response> getExperiences() async {
    return await http.get(Uri.parse('$baseUrl/experiences/'), headers: headers);
  }

  // Login dan menyimpan token.
  static Future<http.Response> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
    }

    return response;
  }

  // Logout dan menghapus token.
  static Future<http.Response> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout/'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      token = null;
    }

    return response;
  }
}
