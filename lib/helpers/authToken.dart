import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStorage {
  final storage = new FlutterSecureStorage();
  final key = "fpa-authentication-token";

  Future<String> getAuthToken() async {
    return await storage.read(key: this.key);
  }

  setAuthToken(token) {
    return storage.write(key: key, value: token);
  }
}
