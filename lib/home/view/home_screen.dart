import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/home/bloc/home_bloc.dart';
import 'package:notification_mindtech_assigment/splash_screen/bloc/splash_bloc.dart';
import 'package:notification_mindtech_assigment/utils/app_util.dart';
import 'package:notification_mindtech_assigment/utils/assets.dart';
import 'package:notification_mindtech_assigment/utils/colors.dart';
import 'package:notification_mindtech_assigment/utils/common_widgets/app_text_widget.dart';
import 'package:notification_mindtech_assigment/utils/extensions.dart';
import 'package:notification_mindtech_assigment/utils/logger/app_logger.dart';
import 'package:notification_mindtech_assigment/utils/notification/model/notification_model.dart';
import 'package:notification_mindtech_assigment/utils/string_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppTextWidget(
              text: 'Home Screen',
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<NotificationAppDataModel>(
                stream: homeBloc.notifModelController,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {

                    return AppTextWidget(
                        text: '${snapshot.data!.toJson().toString()}');
                  }

                  return AppTextWidget(text: 'No Data Found!');
                },
              ),
            )
          ],
        ));
  }
}
