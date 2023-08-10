

import 'package:notification_mindtech_assigment/utils/routes/routes.dart';
import 'package:notification_mindtech_assigment/utils/services/navigation_service.dart';

class SplashBloc {
  redirectToHomeScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
     appNavigationService.pushReplacementNamed(Routes.home_screen);
    });
  }
}

final splashBloc = SplashBloc();
