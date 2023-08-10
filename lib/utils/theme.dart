import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/utils/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    appBarTheme:  AppBarTheme(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF13B9FF),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme:  AppBarTheme(color: AppColors.primary),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF13B9FF),
    ),
  );
}
