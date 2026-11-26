import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

/// Exception untuk menangani kegagalan request API.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Client untuk menghubungkan Flutter dengan Django REST API.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  /// Membentuk alamat endpoint API.
  Uri _uri(String path) {
    final normalizedBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    return Uri.parse('$normalizedBaseUrl$path');
  }

  /// Mengambil seluruh daftar proyek (GET).
  Future<List<Project>> getProjects() async {
    final response = await _client.get(
      _uri('/api/v1/projects/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Mengambil detail proyek berdasarkan UUID (GET).
  Future<Project> getProjectDetail(String id) async {
    final response = await _client.get(
      _uri('/api/v1/projects/$id/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return Project.fromJson(decoded);
  }

  /// Menambahkan proyek baru (POST).
  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/projects/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(project.toJson()),
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return Project.fromJson(decoded);
  }

  /// Login dan mendapatkan token autentikasi.
  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return decoded['token'] as String;
  }

  /// Logout dan menghapus token di backend.
  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );

    _ensureSuccess(response);
  }

  /// Memeriksa status HTTP response.
  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw ApiException(response.statusCode, response.body);
  }

  /// Menutup HTTP client ketika tidak digunakan lagi.
  void dispose() {
    _client.close();
  }
}
