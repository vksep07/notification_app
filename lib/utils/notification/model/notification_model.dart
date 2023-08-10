// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationAppDataModel notificationAppDataModelFromJson(String str) => NotificationAppDataModel.fromJson(json.decode(str));

String notificationAppDataModelToJson(NotificationAppDataModel data) => json.encode(data.toJson());

class NotificationAppDataModel {
  NotificationAppDataModel({
    this.name,
    this.age,

  });

  String? name;
  String? age;


  factory NotificationAppDataModel.fromJson(Map<String, dynamic> json) => NotificationAppDataModel(
    name: json["name"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
  };
}
