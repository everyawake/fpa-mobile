import 'dart:ffi';
import 'dart:io';

import 'package:FPA/env.dart';
import 'package:FPA/helpers/authToken.dart';
import 'package:FPA/models/pushNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// API 호출용 http 라이브러리
import 'package:http/http.dart' as http;
// 지문 인식용 라이브러리(local_auth)
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

  // 지문 인식 관련 함수.
  _getBiometrics(BuildContext context) async {
    final _auth = LocalAuthentication();
    List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    bool isAuthenticated = false;
    String authState = "no-auth-module";

    if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) { // 지문인식 기능 여부 확인
        try {
          // 장비에 지문인식 요청
          isAuthenticated = await _auth.authenticateWithBiometrics(
            localizedReason: "손가락을 올려주세요",
            useErrorDialogs: true,
            stickyAuth: true,
          );

          // 지문인식 결과에 따른 서버 전송값 설정
          if (isAuthenticated) {
            authState = "user-auth-done";
          } else {
            authState = "user-auth-failed";
          }

          // 서버에 전송
          await _sendAuthData(authState);

          Navigator.of(context).pop();
        } on PlatformException catch (e) {
          print("!!! err ${e}");
          await _sendAuthData("user-auth-failed");
        }
      }
    }
  }

  _sendAuthData(String authState) async {
    var url = API_ENDPOINT + "/otid/fpa-auth-send";
    var client = new http.Client();
    var _userToken = await AuthTokenStorage().getAuthToken();

    try {
      await client.post(url, headers: {
        "fpa-authenticate-token": _userToken,
      }, body: {
        "channelId": this.notiData.socketId,
        "authStatus": authState
      });
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
