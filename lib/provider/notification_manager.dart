import 'package:flutter/cupertino.dart';

class CustomNotification {
  final String title;

  final String date;
  final String time;
  final String message;
  CustomNotification({
    required this.title,
    required this.message,
    required this.date,
    required this.time,
  });
}

class NotificationProvider with ChangeNotifier {
  List<CustomNotification> notificationList = [];

  void addNotification(CustomNotification newNotification) {
    notificationList.insert(0, newNotification);
    notifyListeners();
  }

  void deleteNotification(CustomNotification notification) {
    notificationList.removeWhere((element) =>
        element.date == notification.date && element.time == notification.time);
    notifyListeners();
  }
}
