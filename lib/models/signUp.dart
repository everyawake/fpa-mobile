class UserData {
  String _email = "";
  String _password = "";
  String _username = "";
  String _fcmToken = "";

  UserData({String email, String password, String username, String fcmToken}) {
    this._email = email;
    this._password = password;
    this._username = username;
    this._fcmToken = fcmToken;
  }

  String get email => _email;
  String get password => _password;
  String get username => _username;
  String get fcmToken => _fcmToken;

  set email(String value) => _email = value;
  set password(String value) => _password = value;
  set username(String value) => _username = value;
  set fcmToken(String value) => _fcmToken = value;
}
