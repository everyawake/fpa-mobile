import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  SolidButton({@required this.onClick, @required this.text});
  final Function onClick;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: RaisedButton(
        child: Text(
          this.text,
        ),
        onPressed: this.onClick,
        color: Color(0xFF63DBD6),
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}

class StrokeButton extends StatelessWidget {
  StrokeButton({@required this.onClick, @required this.text});
  final Function onClick;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: OutlineButton(
        child: Text(
          this.text,
        ),
        onPressed: () {
          this.onClick();
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
