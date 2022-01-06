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
          border: const OutlineInputBorder(),
            label: Text(label),
        ),
      ),
    );
  }
}
