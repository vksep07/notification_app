import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/app/app_config.dart';
import 'package:notification_mindtech_assigment/utils/colors.dart';

class AppTextWidget extends StatelessWidget {
   String? text;
   double? size;
   FontWeight? fontWeight;
   Color? color;
   double? wordSpacing;
   VoidCallback? onClick;

   AppTextWidget({
    @required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
        text ?? "",
        style: TextStyle(
          fontSize: size ?? appConfig.defaultTextSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? AppColors.black,
          wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
        ),
      )
          : TextButton(
        onPressed: () {
          onClick?.call();
        },
        child: Text(
          text ?? "",
          style: TextStyle(
            fontSize: size ?? appConfig.defaultTextSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? AppColors.black,
            wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
          ),
        ),
      ),
    );
  }
}