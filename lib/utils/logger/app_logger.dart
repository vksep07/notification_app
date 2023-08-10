import 'dart:developer';

class AppLogger {
  static bool logEnable = true;

  static void printLog(
    Object object, {
    String? tag,
  }) {
    if (logEnable) {
      print('[ ${tag ?? 'log'} ] ${object.toString()}');
    }
  }
}
