import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {

  static var standardFormat = DateFormat('yyyy-MM-dd');

  static String dateFormat(DateTime dateTime) {
    return standardFormat.format(dateTime);
  }

  static void snackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blueGrey,
      elevation: 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static bool checkEmpty(String string) {
    if (string.isEmpty) {
      return true;
    }
    return false;
  }

  static validEmail(String email) {
    bool emailValid = false;
    emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

}

const kHintTextStyle = TextStyle(
  color: Colors.grey,
);

const kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

class ColorFilters {
  static const greyscale =  ColorFilter.matrix( <double>[
    /// greyscale filter
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0
  ]);
}

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(defaultPaddingSize/2),
  border: Border.all(color: Colors.grey.withOpacity(0.5))
);

final kBoxDecorationStyleNoColor = BoxDecoration(
    borderRadius: BorderRadius.circular(defaultPaddingSize/2),
    border: Border.all(color: Colors.grey.withOpacity(0.5))
);

Color backgroundColor = HexColor.fromHex('#F8F8F8');

Color buttonColor = Colors.blue;

Color buttonColor2 = Colors.blue;

Color textColor = HexColor.fromHex('#20285A');

Color whiteColor = Colors.white;

Color lightBlackColor = Colors.black45;

Color primaryColor = Colors.blue;

Color blackColor = HexColor.fromHex('#222222');

Color accentColor = Colors.orangeAccent;

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final  buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

//Size
const double defaultPaddingSize = 16.0;


class ImagePath {
  static const String logo = "assets/images/logo.png";
  static const String splashLogo = "assets/images/splash_logo.png";
  static const String splashBackground = "assets/images/splash_background.png";
  static const String preLang = "assets/images/languages.png";
  static const String successBackground = "assets/images/success_background.png";
}

//Icon
class IconPath {
  static const String homeIcon = "assets/icon/home.svg";
  static const String notificationIcon = "assets/icon/notification_icon.svg";
  static const String cameraOverProfileIcon =
      "assets/icon/camera_over_profile_icon.svg";
  static const String contactUsIcon = "assets/icon/contact_us_icon.svg";
  static const String languagesIcon = "assets/icon/languages_icon.svg";
  static const String logo = "assets/icon/logo.svg";
  static const String phoneIcon = "assets/icon/phone_icon.svg";
  static const String settingsIcon = "assets/icon/settings_icon.svg";
  static const String supportIcon = "assets/icon/support_icon.svg";
  static const String termsConditionsIcon =
      "assets/icon/terms_conditions_icon.svg";
  static const String logout = "assets/icon/logout.svg";
}

InputDecoration decoration(String label,{Color? color}) {
  return InputDecoration(
    border: InputBorder.none,
    filled: true,
    fillColor: color?? buttonColor2,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingSize, vertical: defaultPaddingSize / 2),
    labelText: label,
    hintStyle: TextStyle(color: whiteColor),
    labelStyle: TextStyle(color: whiteColor),
  );
}
