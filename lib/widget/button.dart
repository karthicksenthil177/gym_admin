import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String buttonText;
  final Color? color;

  const CustomButton({Key? key, required this.callback,required this.buttonText,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(defaultPaddingSize / 2),
                      side: BorderSide.none)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: defaultPaddingSize)),
              backgroundColor: MaterialStateProperty.all(color ?? buttonColor),
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white,
              ))),
          onPressed: callback,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
