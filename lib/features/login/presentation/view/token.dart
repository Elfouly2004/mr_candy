import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/errors/failure.dart';

class TokenManager {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }
}


Future<Map<String, String>> getHeaders() async {
  final token = await TokenManager.getToken();
  if (token != null) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  return {
    'Content-Type': 'application/json',
  };
}




