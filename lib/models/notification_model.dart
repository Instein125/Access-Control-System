// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    required this.time,
    required this.id,
  });

  String title;
  String message;
  String date;
  String time;
  String id;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        message: json["message"],
        date: json["date"],
        time: json["time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "date": date,
        "time": time,
        "id": id,
      };
}
