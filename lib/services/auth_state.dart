import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

/// Menyimpan status login pengguna selama aplikasi berjalan.
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  // Mengambil token pengguna.
  String? get token => _token;

  // Memeriksa apakah pengguna sudah login.
  bool get isLoggedIn => _token != null;

  // Proses login.
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  // Proses logout.
  Future<void> logout() async {
    final current = _token;

    if (current == null) return;

    try {
      await _apiClient.logout(token: current);
    } on ApiException {
      // Token lokal tetap dihapus meskipun request logout gagal.
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
