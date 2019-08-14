import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: RaisedButton(
        child: Text(
          "회원가입",
        ),
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Hello"),
          ));
        },
        color: Color(0xFF63DBD6),
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}

class StrokeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: OutlineButton(
        child: Text(
          "로그인",
        ),
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Hello"),
          ));
        },
        borderSide: BorderSide(
          color: Colors.white,
        ),
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
