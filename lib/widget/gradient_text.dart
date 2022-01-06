import 'package:flutter/material.dart';
import 'package:gym_admin/util.dart';

class GradientText extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double width;
  final double height;


   const GradientText({
    Key? key,
    required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 20.0,
      decoration: BoxDecoration(gradient: gradient,
          borderRadius: BorderRadius.circular(defaultPaddingSize),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 1.5,
            ),
          ]),
      child: Center(
        child: child,
      ),
    );
  }
}
