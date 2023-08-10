// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

import 'package:notification_mindtech_assigment/utils/notification/model/notification_model.dart';

NotificationData notificationDataFromJson(String str) => NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.notificationType,
    this.silentNotification,
    this.message,
    this.title,
    this.timestamp,
    this.appData,
    this.imageUrl,
  });

  String? notificationType;
  String? silentNotification;
  String? message;
  String? title;
  String? timestamp;
  NotificationAppDataModel? appData;
  String? imageUrl;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notificationType: json["notification_type"] == null ? null : json["notification_type"],
    silentNotification: json["silent_notification"] == null ? null : json["silent_notification"],
    message: json["message"] == null ? null : json["message"],
    title: json["title"] == null ? null : json["title"],
    timestamp: json["timestamp"] == null ? null : json["timestamp"],
  //  appData: json["app_data"] == null ? null : json["app_data"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    appData: json["app_data"] == null ? null : NotificationAppDataModel.fromJson(json["app_data"]),
  );

  Map<String, dynamic> toJson() => {
    "notification_type": notificationType == null ? null : notificationType,
    "silent_notification": silentNotification == null ? null : silentNotification,
    "message": message == null ? null : message,
    "title": title == null ? null : title,
    "timestamp": timestamp == null ? null : timestamp,
    //"app_data": appData == null ? null : appData,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "app_data": appData?.toJson(),

  };
}
