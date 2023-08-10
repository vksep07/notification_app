import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification_mindtech_assigment/app/app.dart';
import 'package:notification_mindtech_assigment/utils/constants.dart';
import 'package:notification_mindtech_assigment/utils/notification/push_notification_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: customerAppApiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId));
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: customerIosAppApiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId));
  }

  /***** For Deep Link  Functionality *****/
  /* deepLinkUtil.initUniLinks();
  deepLinkUtil.initUniLinksListen();
  deepLinkUtil.initDynamicLinks();*/

  /***** For Push Notifications ******/
  PushNotificationsManager.initializePlatformNotifications();
  PushNotificationsManager.intialiseNotificationChannel(
      customerAppChannelId, customerAppChannelName, customerAppChannelDesc);
  PushNotificationsManager.registerFirebaseForNotification();

  // initialize the database
  runApp(const App());
}