import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_mindtech_assigment/home/bloc/home_bloc.dart';
import 'package:notification_mindtech_assigment/utils/common_widgets/alert_dialog/alert_dialogs.dart';
import 'package:notification_mindtech_assigment/utils/logger/app_logger.dart';
import 'package:notification_mindtech_assigment/utils/constants.dart';
import 'package:notification_mindtech_assigment/utils/toast_util.dart';

import 'model/notification_data_model.dart';
import 'model/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



class PushNotificationsManager {
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static void registerFirebaseForNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleRecieveNotificationData(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onLaunch: $message");
      String appData = message.data['app_data'].toString();
    //  ToastUtils.showInfoToast(msg: "onMessageOpenedApp: $message", toastLenght: Toast.LENGTH_LONG,);
      NotificationData notificationDataModel = whenNotificationReceviedBackGeound(message.data);
      PushNotificationsManager.handleClick(notificationDataModel: notificationDataModel);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("onLaunch: $message");
     // ToastUtils.showInfoToast(msg: "getInitialMessage: $message");
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
        //  ToastUtils.showInfoToast(msg: "getInitialMessage: ${message.data['navigateto']}");
          NotificationData notificationDataModel = whenNotificationReceviedBackGeound(message.data);

        }
      }
    });
    FirebaseMessaging.instance.getToken().then((token) {
      assert(token != null);
      print("Push Messaging token: $token");

    });

    FirebaseMessaging.instance.subscribeToTopic("CaptainFreshReseller");
  }

  static void getToken({String? customerId}) {
    FirebaseMessaging.instance.getToken().then((token) {
      assert(token != null);
      print("Push Messaging token: $token");

    });
  }

  static Future displayNotification(NotificationData model, String data) async {
    if (model.imageUrl!.isNotEmpty) {
      _showBigPictureNotificationBase64(model);
    } else {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails('captain_channel_id', 'CaptainFresh',
          channelDescription: 'CaptainFresh Description', importance: Importance.max, priority: Priority.high);
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics =
          new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin!.show(
        0,
        model.title,
        model.message,
        platformChannelSpecifics,
        payload: data,
      );
    }
  }

  static Future<void> intialiseNotificationChannel(String id, String name, String description) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
      description: description,
    );
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  static Future<void> _showBigPictureNotificationBase64(NotificationData model) async {
    final String largeIcon = await _base64encodedImage(model.imageUrl!);
    final String bigPicture = await _base64encodedImage(model.imageUrl!);

    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(bigPicture), //Base64AndroidBitmap(bigPicture),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
        contentTitle: model.title,
        htmlFormatContentTitle: true,
        summaryText: model.message,
        htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        model.title!, model.title!,
        channelDescription: model.message, styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(0, model.title, model.message, platformChannelSpecifics);
  }

  static Future<String> _base64encodedImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  static Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin!
        .initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  static void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    // ToastUtils.showInfoToast(msg: "onDidReceiveLocalNotification", toastLenght: Toast.LENGTH_LONG);

    print('id $id');
  }



  static Future<dynamic> onSelectNotification(String? payload) async {
    //  ToastUtils.showInfoToast(msg: "onSelectNotification", toastLenght: Toast.LENGTH_LONG);

    if (payload != null) {
      debugPrint('onSelectNotification payload: ' + payload);
    }
    AppLogger.printLog('onSelectNotification payload: ' + payload!);
    try {
      NotificationData model = NotificationData.fromJson(json.decode(payload));
      handleClick(notificationDataModel: model);
      AppLogger.printLog('onSelectNotification payload: ' + model.message!);
    } catch (e) {
      AppLogger.printLog('onSelectNotification exceptio: ' + e.toString());
    }
  }

  static handleClick({NotificationData? notificationDataModel}) {
    AppLogger.printLog('handleClick : step 1 -- ${notificationDataModel!.notificationType}');

    switch (notificationDataModel.notificationType) {
      case 0:
        break;
    }
  }

  static checkTypeOfNotification(NotificationData model) {}

  static void generateLocalNotification(
      {String? message,
      String? title,
      String? appData,
      String? imageUrl,
      String? notificationType,
      String? silentNotification,
      String? timestamp,
      int? notificationId,
      String? storeId}) {
    return;
    NotificationData? data = new NotificationData(
        message: message ?? "",
        title: title ?? "",
        appData: new NotificationAppDataModel(name: storeId, age: appData),
        imageUrl: imageUrl ?? "",
        notificationType: notificationType ?? "",
        silentNotification: silentNotification ?? "",
        timestamp: timestamp ?? "");
    PushNotificationsManager.generateNotification(
        notificationData: data, notificationId: notificationId ?? randomNotificationId());
  }

  static Future generateNotification({NotificationData? notificationData, int? notificationId}) async {
    AppLogger.printLog("generateLocalNotification step 1");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('basic_channel', 'CaptainFresh',
        channelDescription: 'CaptainFresh Description', importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
      threadIdentifier: "thread1",
    );
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!.show(
      notificationId ?? 0,
      notificationData!.title,
      notificationData.message,
      platformChannelSpecifics,
      payload: jsonEncode(notificationData.toJson()),
    );
  }

  static void handleRecieveNotificationData(Map<String, dynamic> message) {
     // ToastUtils.showInfoToast(msg: "handleRecieveNotificationData", toastLenght: Toast.LENGTH_LONG);

    AppLogger.printLog("onMessage handleRecieveNotificationData data_load : " + message.toString());
    NotificationData model = whenNotificationReceviedBackGeound(message);
    AppLogger.printLog("onMessage handleRecieveNotificationData data_load 2 : " + json.encode(model));
    //displayNotification(model, json.encode(model));
  }

  static void openScreenOnLaunchAndOnResume(Map<String, dynamic> message) {
    AppLogger.printLog("onresume onSelectNotification data--" + message.toString());
  }

  static NotificationData whenNotificationReceviedBackGeound(Map<String, dynamic> message) {
    AppLogger.printLog('whenNotificationReceviedBackGeound step 1: ');
    try {
      dynamic messagedata = message['message'];
      dynamic title = message['title'];
      dynamic timestamp = message['timestamp'];
      dynamic imageUrl = message['imageUrl'];
      dynamic notificationType = message['navigateto'];
      String appData = message['app_data'];
      AppLogger.printLog('whenNotificationReceviedBackGeound appdata type  ${ message['app_data'].runtimeType} ');
      Map<String,dynamic> valueMap = json.decode(appData);
      AppLogger.printLog('whenNotificationReceviedBackGeound valueMap type  ${ valueMap.runtimeType} ');

      NotificationAppDataModel   notificationAppDataModel = NotificationAppDataModel.fromJson(valueMap);
      AppLogger.printLog('whenNotificationReceviedBackGeound valueMap decode  ${ notificationAppDataModel.age} ');
      homeBloc.notifModelController.add(notificationAppDataModel);

      AppAlertDialog.showDataDialog(title: notificationAppDataModel.name,age: notificationAppDataModel.age);
    /*NotificationAppDataModel notificationAppDataModel =
          NotificationAppDataModel(age: valueMap['data_id'], name: valueMap['store_id']);*/

      NotificationData model = new NotificationData();
      model.message = messagedata;
      model.title = title;
      model.timestamp = timestamp;
      model.imageUrl = imageUrl;
      model.notificationType = notificationType;
      model.appData = notificationAppDataModel;
      AppLogger.printLog('whenNotificationReceviedBackGeound step 2:  ${notificationAppDataModel.name} ');
      return model;
    } catch (e) {
      AppLogger.printLog('registerFirebaseForNotification exception: ' + e.toString());
    }
    return new NotificationData();
  }

  static Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
    AppLogger.printLog(" myBackgroundMessageHandler  i AM CALLING: ");
    //ToastUtils.showInfoToast(msg: "myBackgroundMessageHandler", toastLenght: Toast.LENGTH_LONG);
    /*if (message.data.isNotEmpty) {
      // Handle data message
      final dynamic data = message.data;
      try {
        NotificationData? model = whenNotificationReceviedBackGeound(message.data);
        displayNotification(model, json.encode(model));
        AppLogger.printLog('myBackgroundMessageHandler payload: ' + model.message!);
      } catch (e) {
        AppLogger.printLog('myBackgroundMessageHandler exceptio: ' + e.toString());
      }
    }
    if (message.notification != null) {
      // Handle notification message
      final dynamic notification = message.notification;
    }*/
  }

  static Future<void> showProgressNotification(
      {int? progress, String? notificationTitle, String? notificationDesc, String? progressPercentage}) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'progress channel', 'progress channel',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: 100,
        progress: progress!);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!
        .show(001, '$notificationTitle', '$notificationDesc', platformChannelSpecifics, payload: '');
  }

  void openTestNotification() {
    NotificationData? data = new NotificationData(
        message: "Click here to open the file",
        title: "File Downloaded Sucessfully!",
        appData: new NotificationAppDataModel(),
        imageUrl: "",
        notificationType: NOTIFICATION,
        silentNotification: "",
        timestamp: "");
    PushNotificationsManager.generateNotification(
        notificationData: data, notificationId: 007 ?? randomNotificationId());
    /* PushNotificationsManager.generateLocalNotification(
        notificationData: data, notificationId: 0231);*/
  }

  static int randomNotificationId() {
    Random random = new Random();
    int randomNumber = random.nextInt(1000);
    return randomNumber;
  }

  static void handleBackgroundNotificationData() {
    ToastUtils.showInfoToast(msg: "varun -}", toastLenght: Toast.LENGTH_LONG);

  }
}
