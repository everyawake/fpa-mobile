import 'dart:convert';

import 'package:FPA/helpers/authToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:FPA/components/formInput.dart';
import 'package:FPA/components/solidButtons.dart';
import 'package:FPA/helpers/validators.dart';
import 'package:FPA/pages/signUp.dart';

class SignIn extends StatefulWidget {
  SignIn({this.argument, Key key}) : super(key: key);
  final argument;

  @override
  SignInState createState() => SignInState(argument: this.argument);
}

class SignInState extends State<SignIn> {
  SignInState({this.argument});
  final argument;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    if (this.argument is UserData) {
      UserData userData = this.argument;
      setState(() {
        _email = userData.email;
        _password = userData.password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
        backgroundColor: Color(0xFF3B3E45),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF3B3E45),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MyInputFormField(
                    initialValue: _email,
                    validator: validateEmail,
                    onSaved: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    labelText: "이메일(Email)",
                    hintText: "이메일을 입력하세요",
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
                      initialValue: _password,
                      validator: validatePassword,
                      onSaved: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      labelText: "비밀번호(Password)",
                      hintText: "비밀번호를 입력해주세요",
                      obsecureText: true,
                      maxLength: 20,
                      textInputType: TextInputAction.next,
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (term) {
                        _passwordFocus.unfocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SubmitButton(
                      formKey: _formKey,
                      email: _email,
                      password: _password,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatefulWidget {
  SubmitButton({
    @required this.formKey,
    @required this.email,
    @required this.password,
    Key key,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final String email;
  final String password;

  @override
  SubmitButtonState createState() => SubmitButtonState(
        formKey: formKey,
        email: email,
        password: password,
      );
}

class SubmitButtonState extends State<SubmitButton> {
  SubmitButtonState(
      {@required this.formKey, @required this.email, @required this.password});

  final GlobalKey<FormState> formKey;
  final String email;
  final String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: RaisedButton(
        child: _renderButtonConent(),
        onPressed: this.isLoading
            ? null
            : () {
                if (this.formKey.currentState.validate()) {
                  this.formKey.currentState.save();
                  _doSignIn(context);
                }
              },
        color: Color(0xFF63DBD6),
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
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
    return Text("로그인");
  }

  _doSignIn(BuildContext ctx) async {
    var url = "http://192.168.1.192:3000/users/signin";
    var client = new http.Client();
    setState(() {
      isLoading = true;
    });
    try {
      var response =
          await client.post(url, body: {"id": email, "password": password});
      var message = "로그인에 실패했습니다.";
      var parsedBody = json.decode(response.body);
      if (response.statusCode == 200) {
        print("!!! SignIn-token: " + parsedBody["token"]);
        print("!!! SignIn-data: " + parsedBody["data"].toString());
        message = "로그인 성공!!";
        AuthTokenStoreage().setAuthToken(parsedBody["token"]);
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
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