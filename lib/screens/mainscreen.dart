import 'package:access_control_system/helper/pushnotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainScreen extends StatefulWidget {
  static const String route = "/main_screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // String doorStatus = "Close";
  // String lightStatus = "On";
  // double smokePercent = 0.6;
  late User? currentUser;
  late final DocumentReference userRef;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      PushNotificationService pushNotificationService =
          PushNotificationService();

      pushNotificationService.getToken(currentUser!.uid);
    }
    userRef =
        FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        title: Text(
          "Welcome",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.notification_add,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
            stream: userRef.snapshots(),
            builder: (context, snapshot) {
              // if(snapshot.hasData && !snapshot.hasError && snapshot.data !=null){

              // }
              DocumentSnapshot data = snapshot.data as DocumentSnapshot;
              String doorStatus = data['doorStatus'].toString();
              String lightStatus = data["lightStatus"].toString();
              String smokePercent = data['smokePercent'].toString();

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connected Devices",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DoorContainer(size, context, doorStatus),
                        lightContainer(size, context, lightStatus),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    smokeContainer(size, context, smokePercent),
                  ]);
            }),
      ),
    );
  }

  Container smokeContainer(
      Size size, BuildContext context, String smokePercent) {
    double percent = double.parse(smokePercent);
    return Container(
      height: size.height * 0.35,
      width: size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 251, 188, 254),
                offset: Offset(10, 5),
                blurRadius: 15,
                spreadRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.fireplace_rounded,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            const Text(
              "Smoke Detector",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 10.0,
              animation: true,
              percent: percent,
              footer: Text(
                "${(percent * 100).round()}%",
                style: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: percent > 0.5
                  ? const Color.fromARGB(255, 236, 64, 49)
                  : Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Container lightContainer(
      Size size, BuildContext context, String lightStatus) {
    return Container(
      height: size.height * 0.35,
      width: size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 251, 188, 254),
                offset: Offset(10, 5),
                blurRadius: 15,
                spreadRadius: 2)
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            const Text(
              "Light",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            lightStatus == "Off"
                ? const Text(
                    "On",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                : const Text(
                    "Off",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
            CupertinoSwitch(
              value: lightStatus == "On",
              onChanged: (value) {
                setState(() {
                  if (lightStatus == "Off") {
                    userRef.update({"lightStatus": "On"});
                    // lightStatus = "On";
                  } else {
                    userRef.update({"lightStatus": "Off"});
                    // lightStatus = "Off";
                  }
                });
              },
              activeColor: Colors.orange,
            )
          ],
        ),
      ),
    );
  }

  Container DoorContainer(Size size, BuildContext context, String doorStatus) {
    return Container(
      height: size.height * 0.35,
      width: size.height * 0.25,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 251, 188, 254),
                offset: Offset(10, 5),
                blurRadius: 15,
                spreadRadius: 2)
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.door_back_door_outlined,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            const Text(
              "Door",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            doorStatus == "Open"
                ? const Text(
                    "Lock",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                : const Text(
                    "Unlock",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
            CupertinoSwitch(
              value: doorStatus == "Close",
              onChanged: (value) {
                setState(() {
                  if (doorStatus == "Open") {
                    userRef.update({"doorStatus": "Close"});
                    // doorStatus = "Close";
                  } else {
                    userRef.update({"doorStatus": "Open"});
                    // doorStatus = "Open";
                  }
                });
              },
              activeColor: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
