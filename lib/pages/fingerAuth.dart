import 'dart:ffi';
import 'dart:io';

import 'package:FPA/models/pushNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';

class FingerAuthPage extends StatelessWidget {
  FingerAuthPage({this.notiData});
  final PushNotification notiData;

  @override
  Widget build(BuildContext context) {
    this._getBiometrics(context);

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

  _getBiometrics(BuildContext context) async {
    final _auth = LocalAuthentication();
    List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    bool isAuthenticated = false;

    if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        try {
          isAuthenticated = await _auth.authenticateWithBiometrics(
            localizedReason: "Finger up",
            useErrorDialogs: true,
            stickyAuth: true,
          );
        } on PlatformException catch (e) {
          print("!!! err ${e}");
        }
      }
    }

    print("!!!! AUTH DONE: ${isAuthenticated}");
    Navigator.of(context).pop();
  }
}
