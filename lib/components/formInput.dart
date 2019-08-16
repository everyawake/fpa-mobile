import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInputFormField extends StatelessWidget {
  MyInputFormField({
    @required this.validator,
    @required this.labelText,
    this.onSaved,
    this.initialValue,
    this.hintText,
    this.autofocus = false,
    this.obsecureText = false,
    this.textInputType = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType,
    this.controller,
    this.maxLength,
  });

  final Function(String) validator;
  final Function(String) onSaved;
  final Function(String) onFieldSubmitted;
  final String initialValue;
  final String labelText;
  final String hintText;
  final bool autofocus;
  final bool obsecureText;
  final TextInputAction textInputType;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: this.autofocus,
      initialValue: this.initialValue,
      decoration: InputDecoration(
        labelText: this.labelText,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        hintText: this.hintText,
        hintStyle: TextStyle(
          color: Colors.white24,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF63DBD6),
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.next,
      focusNode: this.focusNode,
      onFieldSubmitted: this.onFieldSubmitted,
      obscureText: this.obsecureText,
      validator: this.validator,
      onSaved: this.onSaved,
      keyboardType: this.keyboardType,
      controller: this.controller,
      maxLength: this.maxLength,
    );
  }
}
