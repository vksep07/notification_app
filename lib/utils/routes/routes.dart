import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/home/view/home_screen.dart';
import 'package:notification_mindtech_assigment/splash_screen/view/splash_screen.dart';

class Routes {
  static const String home_screen = 'home_Screen';
  static const String splash = 'splash';

  static Route<dynamic>? getGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: splash),
          builder: (_) => SplashScreen(),
        );

      case home_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: home_screen),
          builder: (_) => HomeScreen(),
        );



      default:
        return null;
    }
  }
}
