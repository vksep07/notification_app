import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static  Color primary = Color(0xFFD73326);//getColorFromHex('0061c2');

  //FONT BLACK COLORS
  static const Color fontDark = Color(0xFF414E5A);
  static const Color fontBlack = Color(0xFF212121);
  static const Color fontNeutral = Color(0xFF788898);

  //BORDER
  static const Color borderLight = Color(0xFFE6E6E6);

  //PAYMENT STATUS CARD COLORS
  static const Color status1 = Color(0xFFFFD54F);
  static const Color status2 = Color(0xFF66BB6A);

  static const Color secondry = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFbdbdbc);
  static const Color textGrey = Color(0xFF747474);
  static const Color fontGrey = Color(0xFF788898);
  static const Color blue = Color(0xFF2563EB);

  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFd3d3d3);

  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color white = Colors.white;

  static const Color whatsappGreen = Color(0xff25D366);

  static const Color transparent = Colors.transparent;

  /* Ui Fixes Color code latest */
  static Color bg_screen_color = getColorFromHex("#fafafa");
  static Color button_border_color = getColorFromHex("#E2E2E2");
  static Color fontGreyColor= getColorFromHex('#212121');
  static Color fontGreyDarkColor=getColorFromHex('#788898');
  static Color blueButtonColor=getColorFromHex('#2563EB');
  static Color offWhite=getColorFromHex('f5f5f5');


  static int header01 = 0xff151a56;
  static int purple01 = 0xff918fa5;
  static int purple02 = 0xff6b6e97;
  static int yellow01 = 0xffeaa63b;
  static int yellow02 = 0xfff29b2b;
  static int bg = 0xfff5f3fe;
  static int bg01 = 0xff6f75e1;
  static int bg02 = 0xffc3c5f8;
  static int bg03 = 0xffe8eafe;
  static int text01 = 0xffbec2fc;
  static int grey01 = 0xffe9ebf0;
  static int grey02 = 0xff9796af;


}
