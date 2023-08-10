import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastUtils {
  static void showInfoToast(
      {required String msg, Toast? toastLenght, MaterialColor? color}) {
  Fluttertoast.showToast(
        msg: "$msg",
        toastLength: toastLenght ?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
