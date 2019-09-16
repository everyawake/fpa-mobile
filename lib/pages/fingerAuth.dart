import 'package:FPA/models/pushNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FingerAuthPage extends StatelessWidget {
  FingerAuthPage({this.notiData});
  final PushNotification notiData;

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
          ],
        ),
      ),
    );
  }
}
