import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    dependsOnLoginStatus();
  }

  dependsOnLoginStatus() async {
    bool isLoggedIn = await SessionManager().getLoggedInStatus();
    bool initialLoginOver = await SessionManager().getInitialLoginOver();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return !initialLoginOver
                  ? const LoginScreen()
                  : isLoggedIn
                  ? const Dashboard()
                  : const LoginScreen();
            })));
  }


  @override
  Widget build(BuildContext context) {
    dependsOnLoginStatus();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Image.asset(ImagePath.logo)));
  }
}
