import 'package:FPA/pages/signin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
      home: MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case "/signup":
            return MaterialPageRoute(builder: (context) => SignUp());
          case "/signin":
            return MaterialPageRoute(
              builder: (context) => SignIn(
                arguments: settings.arguments,
              ),
            );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    this._initializeGCM();

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
                onClick: () {
                  Navigator.pushNamed(context, "/signin");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _initializeGCM() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('onMessage $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('onResume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch $message');
      },
    );
  }
}
