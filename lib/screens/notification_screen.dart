// ignore_for_file: deprecated_member_use

import 'package:access_control_system/dummy_data.dart';
import 'package:access_control_system/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String route = "/notification_screen";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final CollectionReference documentRef;
  var notificationList = [];
  @override
  void initState() {
    super.initState();
    User? currentUser = FirebaseAuth.instance.currentUser;
    fetchNotifications(currentUser!.uid);
  }

  fetchNotifications(String uid) async {
    var noti = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("notifications")
        .get();
    mapNotifications(noti);
  }

  mapNotifications(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var list = snapshot.docs
        .map((notification) => NotificationModel(
            title: notification["title"],
            message: notification["message"],
            date: notification["date"],
            time: notification["time"],
            id: notification.id))
        .toList();
    setState(() {
      notificationList = list.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    void deleteNotification(String id) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .collection("notifications")
          .doc(id)
          .delete();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).primaryColor, size: 30),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Smoke Alerts",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          final item = notificationList[index];
          return Dismissible(
            key: Key(item.id),
            onDismissed: (direction) {
              setState(() {
                deleteNotification(item.id);
                notificationList.removeAt(index);
              });
            },
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(color: Colors.red),
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(144, 202, 249, 1), width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 20),
                leading: const Icon(
                  Icons.notifications_active,
                  color: Colors.orange,
                  size: 30,
                ),
                title: Text(
                  notificationList[index].title.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        notificationList[index].date,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text(
                        notificationList[index].time,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  notificationList[index].message,
                  style: const TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
