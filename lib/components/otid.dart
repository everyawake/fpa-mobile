import 'dart:convert';

import 'package:FPA/components/solidButtons.dart';
import 'package:FPA/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTIDViewer extends StatefulWidget {
  OTIDViewer({Key key, @required this.userToken}) : super(key: key);
  final String userToken;

  @override
  OTIDViewerState createState() => OTIDViewerState();
}

class OTIDViewerState extends State<OTIDViewer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.generateOTID(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        var isLoading = false;
        var otidWidget;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            isLoading = true;
            otidWidget = CircularProgressIndicator();
            break;
          case ConnectionState.done:
            isLoading = false;
            if (snapshot.hasData) {
              otidWidget = Text(
                "${snapshot.data}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0),
                textAlign: TextAlign.center,
              );
            } else {
              otidWidget = Text(
                "- OTID 생성 실패 -",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0),
                textAlign: TextAlign.center,
              );
            }

            break;
        }

        return Column(
          children: <Widget>[
            Text(
              "접속하려는 사이트에 이 OTID를 입력해주세요",
              style: TextStyle(color: Colors.white60, fontSize: 10.0),
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0), child: otidWidget),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SolidButton(
                text: "OTID 재생성",
                onClick: isLoading
                    ? null
                    : () {
                        setState(() {});
                      },
              ),
            )
          ],
        );
      },
    );
  }

  Future<String> generateOTID() async {
    var url = API_ENDPOINT + "/otid/generate";
    var client = new http.Client();
    try {
      var response = await client.post(
        url,
        headers: {
          "fpa-authenticate-token": this.widget.userToken,
        },
      );

      var parsedBody = json.decode(response.body);
      return parsedBody["result"];
    } catch (e) {
      client.close();
    }
  }
}
