import 'dart:convert';

import 'package:FPA/helpers/authToken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:device_id/device_id.dart";
import 'package:http/http.dart' as http;

import 'package:FPA/components/formInput.dart';
import "package:FPA/helpers/validators.dart";

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _username = "";

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repasswordFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  TextEditingController _passwordController = new TextEditingController();
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  UserData _data = new UserData();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      this._data._fcmToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    _passwordController.addListener(onPasswordChange);

    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: Color(0xFF3B3E45),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF3B3E45),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyInputFormField(
                  validator: validateEmail,
                  onSaved: (value) {
                    this._data._email = value;
                    setState(() {
                      _email = value;
                    });
                  },
                  labelText: "이메일(Email)",
                  hintText: "로그인과 인증에 사용할 이메일을 입력하세요",
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputType: TextInputAction.next,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _passwordFocus);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: validatePassword,
                    onSaved: (value) {
                      this._data._password = value;
                      setState(() {
                        _password = value;
                      });
                    },
                    labelText: "비밀번호(Password)",
                    hintText: "비밀번호를 입력해주세요(6~20자 내)",
                    obsecureText: true,
                    maxLength: 20,
                    textInputType: TextInputAction.next,
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _passwordFocus, _repasswordFocus);
                    },
                    controller: _passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: (value) {
                      var passwordValidator = validatePassword(value);
                      if (passwordValidator != null) return passwordValidator;
                      if (_password != value) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    labelText: "비밀번호 재입력(Re-Password)",
                    hintText: "비밀번호를 다시 입력하세요",
                    obsecureText: true,
                    maxLength: 20,
                    textInputType: TextInputAction.next,
                    focusNode: _repasswordFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _repasswordFocus, _usernameFocus);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: validateUsername,
                    onSaved: (value) {
                      this._data._username = value;
                      setState(() {
                        _username = value;
                      });
                    },
                    labelText: "이름(Username)",
                    hintText: "다른 사용자에게 보여질 이름을 적어주세요",
                    focusNode: _usernameFocus,
                    onFieldSubmitted: (term) {
                      _usernameFocus.unfocus();
                    },
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        formKey: _formKey,
        userData: _data,
      ),
    );
  }

  onPasswordChange() {
    String text = _passwordController.text;
    setState(() {
      _password = text;
    });
  }
}

class SubmitButton extends StatefulWidget {
  SubmitButton({@required this.formKey, @required this.userData, Key key})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final UserData userData;

  @override
  SubmitButtonState createState() => SubmitButtonState(
        formKey: formKey,
        userData: userData,
      );
}

class SubmitButtonState extends State<SubmitButton> {
  SubmitButtonState({@required this.formKey, @required this.userData});

  final GlobalKey<FormState> formKey;
  final UserData userData;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: _renderButtonConent(),
      onPressed: isLoading
          ? null
          : () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                this._submitSignUp(context);
              }
            },
      color: Color(0xFF63DBD6),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Widget _renderButtonConent() {
    if (this.isLoading) {
      return SizedBox(
        child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 2.0),
        height: 20.0,
        width: 20.0,
      );
    }
    return Text("회원가입");
  }

  _submitSignUp(BuildContext ctx) async {
    var url = "http://192.168.1.192:3000/users/signup";
    var client = new http.Client();
    setState(() {
      isLoading = true;
    });

    var deviceUUID = await DeviceId.getID;
    try {
      var response = await client.post(url, body: {
        "id": this.userData.email,
        "username": this.userData.username,
        "device_uuid": deviceUUID,
        "fcm_token": this.userData.fcmToken,
        "email": this.userData.email,
        "password": this.userData.password
      });

      var message = "회원가입에 실패했습니다!";
      if (response.statusCode == 201) {
        message = "회원가입 완료!";
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

      Navigator.of(context)
          .pushReplacementNamed("/signin", arguments: this.userData);
    } finally {
      client.close();
      setState(() {
        isLoading = false;
      });
    }
  }
}

_fieldFocusChange(
  BuildContext context,
  FocusNode currentFocus,
  FocusNode nextFocus,
) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

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

  setEmail(String value) => _email = value;
  setPassword(String value) => _password = value;
  setUsername(String value) => _username = value;
  setFcmToken(String value) => _fcmToken = value;
}
