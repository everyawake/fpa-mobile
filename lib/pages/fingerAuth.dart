import 'dart:ffi';
import 'dart:io';

import 'package:FPA/env.dart';
import 'package:FPA/helpers/authToken.dart';
import 'package:FPA/models/pushNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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
    String authState = "no-auth-module";

    if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        try {
          isAuthenticated = await _auth.authenticateWithBiometrics(
            localizedReason: "손가락을 올려주세요",
            useErrorDialogs: true,
            stickyAuth: true,
          );
        } on PlatformException catch (e) {
          print("!!! err ${e}");
        }
      }
    }

    if (isAuthenticated) {
      authState = "user-auth-done";
    } else {
      authState = "user-auth-failed";
    }

    await _sendAuthData(authState);

    Navigator.of(context).pop();
  }

  _sendAuthData(String authState) async {
    var url = API_ENDPOINT + "/otid/fpa-auth-send";
    var client = new http.Client();
    var _userToken = await AuthTokenStorage().getAuthToken();

    var fpaData =
        FpaSendData(channelId: this.notiData.socketId, authStatus: authState);

    try {
      await client.post(url,
          headers: {
            "fpa-authenticate-token": _userToken,
          },
          body: fpaData);
    } catch (err) {
      client.close();
      print("!!!! err ${err}");
    }
  }
}

class FpaSendData {
  final String channelId;
  final String authStatus;

  FpaSendData({
    this.channelId,
    this.authStatus,
  });
}
