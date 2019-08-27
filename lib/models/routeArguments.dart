import 'package:FPA/models/signUp.dart';

class SignInRoutingArgument {
  UserData _userData;

  SignInRoutingArgument({UserData userData}) {
    this._userData = userData;
  }

  UserData get userData => this._userData;

  set userData(UserData userData) => this._userData = userData;
}
