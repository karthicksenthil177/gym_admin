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
  Color borderColor;
  Color foregroundColor;
  Color backgroundColor;
  CustomTextButton(
      {
        Key? key,
        required this.text,
        required this.callback,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 16.0,
      this.color = Colors.black,
        this.foregroundColor = Colors.blue,
        this.borderColor = Colors.blue,
        this.backgroundColor = Colors.white,
      this.padding = defaultPaddingSize/2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(
            text,
            style: TextStyle(fontSize: 14)
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(padding)),
            foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    side: BorderSide(color: borderColor)
                )
            )
        ),
        onPressed: callback
    );
  }
}