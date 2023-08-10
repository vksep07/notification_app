import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/splash_screen/bloc/splash_bloc.dart';
import 'package:notification_mindtech_assigment/utils/app_util.dart';
import 'package:notification_mindtech_assigment/utils/assets.dart';
import 'package:notification_mindtech_assigment/utils/colors.dart';
import 'package:notification_mindtech_assigment/utils/common_widgets/app_text_widget.dart';
import 'package:notification_mindtech_assigment/utils/extensions.dart';
import 'package:notification_mindtech_assigment/utils/logger/app_logger.dart';
import 'package:notification_mindtech_assigment/utils/string_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    AppUtil.setStatusBarColor(statusBarColor: AppColors.primary);
    AppLogger.printLog("open splash screen");
    super.initState();
    splashBloc.redirectToHomeScreen();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

   // splashBloc.changeIntoJson();
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    animationController.forward();

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: FadeTransition(
                opacity: animationController
                    .drive(CurveTween(curve: Curves.easeOut)),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(Assets.appLogo, fit: BoxFit.contain,color: AppColors.white,),
                ),
              ),
            ),
            20.heightBox,
            Center(
              child: FadeTransition(
                opacity: animationController
                    .drive(CurveTween(curve: Curves.easeOut)),
                child: AppTextWidget(
                text: stringConstant.appName,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  size: 26,
                ),
              ),
            ),

          ],
        ));
  }
}
