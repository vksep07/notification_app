import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_mindtech_assigment/utils/assets.dart';
import 'package:notification_mindtech_assigment/utils/common_widgets/app_text_widget.dart';
import 'package:notification_mindtech_assigment/utils/extensions.dart';
import 'package:notification_mindtech_assigment/utils/services/navigation_service.dart';

class AppAlertDialog {
  static void showDataDialog({String? title, String? age}) {
    Dialog? logoutDialog;

    if (logoutDialog != null) {
      appNavigationService.pop();
    }
    logoutDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            40.heightBox,
            Icon(Icons.location_history_sharp,size: 50,),
            20.heightBox,
            getRowItem(title: 'Name', value: title)!,
            20.heightBox,
            getRowItem(title: 'Age', value: age)!,

            40.heightBox,
          ],
        ),
      ),
    );
    //CALL TO OPEN DIALOG
    showDialog(
        context: appNavigationService.currentContext!,
        barrierDismissible: true,
        builder: (BuildContext context) => logoutDialog!);
  }

  static Widget? getRowItem({String? title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppTextWidget(text: title,fontWeight:FontWeight.bold,size: 16, ),
        AppTextWidget(text: value,fontWeight:FontWeight.bold,size: 16, ),
      ],
    );
  }
}
