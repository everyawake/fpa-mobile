import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String _email = "";
  String _password = "";
  String _rePassword = "";
  String _username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: Color(0xFF3B3E45),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF3B3E45),
      body: Center(
        child: Column(
          children: <Widget>[Text("hello")],
        ),
      ),
      bottomNavigationBar: RaisedButton(
        child: Text("Button"),
        onPressed: () {},
      ),
    );
  }
}
