import 'dart:convert';

import 'package:FPA/env.dart';
import 'package:FPA/helpers/authToken.dart';
import 'package:FPA/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
              child: this.renderProfileData(),
            )
          ],
        ),
      ),
    );
  }

  renderProfileData() {
    return FutureBuilder(
      future: this.getMyProfile(),
      builder: (BuildContext context, AsyncSnapshot<ProfileData> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              return Text("${snapshot.data.username}님 어서오세요!");
            }
            return Text("정보 없음"); // TODO: 로그인 버튼 혹은 => 메인페이지로 리다이렉트
        }
      },
    );
  }

  Future<ProfileData> getMyProfile() async {
    var url = API_ENDPOINT + "/auth/";
    var client = new http.Client();
    var userToken = await AuthTokenStorage().getAuthToken();
    ProfileData data;

    try {
      var response = await client.get(
        url,
        headers: {
          "fpa-authenticate-token": userToken,
        },
      );

      var parsedBody = json.decode(response.body);
      data = ProfileData.fromJson(parsedBody);
    } catch (e) {
      client.close();
    }

    return data;
  }
}
