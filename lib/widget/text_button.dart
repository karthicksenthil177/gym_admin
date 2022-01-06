import 'dart:ui';

import 'package:flutter/material.dart';

import '../util.dart';

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  FontWeight fontWeight;
  double fontSize;
  Color color;
  double padding;

  CustomTextButton(
      {
        Key? key,
        required this.text,
        required this.callback,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 14.0,
      this.color = Colors.black,
      this.padding = defaultPaddingSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(padding))),
      onPressed: callback,
      child: Text(
        text,
        style:
            TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
      ),
    );
  }
}
