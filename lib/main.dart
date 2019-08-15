import 'package:flutter/material.dart';
import "components/solidButtons.dart";
import 'pages/signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (context) => MyHomePage(),
        "/signup": (context) => SignUp(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3B3E45),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome To\nFPA',
              style: TextStyle(color: Colors.white, fontSize: 32.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SolidButton(
                  text: "회원가입",
                  onClick: () {
                    Navigator.pushNamed(context, "/signup");
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: StrokeButton(
                text: "로그인",
                onClick: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
