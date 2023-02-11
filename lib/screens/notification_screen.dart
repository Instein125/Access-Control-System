import 'package:access_control_system/dummy_data.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String route = "/notification_screen";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
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
        itemCount: notiList.length,
        itemBuilder: (context, index) {
          final item = notiList[index];
          return Dismissible(
            key: Key(item.time),
            onDismissed: (direction) {
              setState(() {});
            },
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(
                  // border: Border.all(
                  //     color: Color.fromRGBO(144, 202, 249, 1), width: 2),
                  // borderRadius: BorderRadius.circular(20),
                  color: Colors.red),
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(144, 202, 249, 1), width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 20),
                leading: const Icon(
                  Icons.notifications_active,
                  color: Colors.orange,
                  size: 30,
                ),
                title: Text(
                  notiList[index].title.toUpperCase(),
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
                        notiList[index].date,
                        style: const TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      Text(
                        notiList[index].time,
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
                  notiList[index].message,
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
