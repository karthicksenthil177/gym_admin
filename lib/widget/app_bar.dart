import 'package:flutter/material.dart';
import 'package:gym_admin/util.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
