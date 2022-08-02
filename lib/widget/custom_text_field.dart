import 'package:flutter/material.dart';
import 'package:gym_admin/util.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomTextField({Key? key,required this.controller,required this.label,this.textInputType = TextInputType.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPaddingSize/2),
      child: TextField(
        controller: controller,
        keyboardType : textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12),
          focusedBorder:  OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(12.0),
            borderSide:  BorderSide(color: greyColor, width: 0.0),
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // width: 0.0 produces a thin "hairline" border
            borderSide:  BorderSide(color: greyColor, width: 0.0),
          ),
          disabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // width: 0.0 produces a thin "hairline" border
            borderSide:  BorderSide(color: greyColor, width: 0.0),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // width: 0.0 produces a thin "hairline" border
            borderSide:  BorderSide(color: greyColor, width: 0.0),

          ),
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: greyColor,
            hintText: label,
          hintStyle: TextStyle(color: Colors.black87)
        ),
      ),
    );
  }
}
