
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_admin/pre_dashboard/splash.dart';
import 'package:gym_admin/util.dart';

class MyApp extends StatefulWidget {

  const MyApp({Key? key}):super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Gym Trainee',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        backgroundColor: Colors.white
      ),home:const SplashScreen(),
    );
  }
}
