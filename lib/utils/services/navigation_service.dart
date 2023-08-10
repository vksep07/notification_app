import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNavigationService {
  final GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get currentContext => myNavigatorKey.currentContext;

  State? get currentState => myNavigatorKey.currentState;

  Future<dynamic>? pushNamed(String routeName, {dynamic arguments}) {
    return myNavigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? pushReplacementNamed(String routeName, {dynamic arguments}) {
    return myNavigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic>? pushAndRemoveUntil(
    Route route,
    bool Function(Route<dynamic>) predicate,
  ) {
    return myNavigatorKey.currentState?.pushAndRemoveUntil(route, predicate);
  }

  Future<dynamic>? pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    dynamic arguments,
  }) {
    return myNavigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void pop() {
    return myNavigatorKey.currentState?.pop();
  }

  void killApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  String? getCurrentScreenName() {
    String? currentScreenName;
    myNavigatorKey.currentState?.popUntil((route) {
      currentScreenName = route.settings.name;
      return true;
    });
    return currentScreenName ?? "";
  }

// CHECK IF ANY DIALOG IS OPENED OR NOT
  bool _isDialogOpened = false;

  Future<dynamic>? showPopUp(
      {required Widget Widget,
      required bool barrierDismissible,
      Function? onPopAction}) async {
    if (_isDialogOpened == false) {
      _isDialogOpened = true;
      await showDialog(
          context: appNavigationService.currentContext!,
          barrierDismissible: barrierDismissible,
          // contentPadding: EdgeInsets.zero,
          builder: (BuildContext context) => Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Widget,
              )).then((value) {
        _isDialogOpened = false;
        onPopAction != null ? onPopAction()! : null;
      });
    } else {
      null;
    }
  }
}

final AppNavigationService appNavigationService = AppNavigationService();
