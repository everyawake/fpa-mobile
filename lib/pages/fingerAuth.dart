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
            Icon(Icons.fingerprint, color: Colors.white, size: 128.0),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Reqeust from [${this.notiData.thirdPartyName}]',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
