import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRepository{
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveTokens({required String accessToken, required String refreshToken,}) async{
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

}