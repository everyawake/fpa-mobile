import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStoreage {
  final storage = new FlutterSecureStorage();
  final key = "fpa-authentication-token";

  getAuthToken() async {
    return await storage.read(key: this.key);
  }

  setAuthToken(token) {
    return storage.write(key: key, value: token);
  }
}
