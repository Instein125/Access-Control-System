// ignore_for_file: deprecated_member_use
import 'package:access_control_system/screens/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:access_control_system/screens/mainscreen.dart';
import 'package:access_control_system/screens/notification_screen.dart';
import 'package:access_control_system/screens/registratio_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  addNotification(message.data);
}

final navigatorKey = GlobalKey<NavigatorState>();

void addNotification(Map<String, dynamic> notificationData) {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final notificationRef = FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser!.uid)
      .collection("notifications")
      .doc();
  notificationRef.set({
    "title": notificationData["title"],
    "message": notificationData["message"],
    "date": notificationData["date"],
    "time": notificationData["time"],
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    print(message.data);

    // if (navigatorKey.currentContext != null) {
    //   showDialog(
    //       context: navigatorKey.currentContext!,
    //       builder: (_) => AlertDialog(
    //             backgroundColor: Colors.white,
    //             icon: Image.asset(
    //               "assets/images/Fire_safety_1-removebg-preview.png",
    //               height: 200,
    //               width: 200,
    //             ),
    //             title: Text(message.data["title"]),
    //             elevation: 40,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(20)),
    //             actions: [
    //               TextButton(
    //                   onPressed: () {},
    //                   child: TextButton(
    //                     onPressed: () {
    //                       Navigator.pop(navigatorKey.currentContext!);
    //                     },
    //                     child: const Text(
    //                       "Ok",
    //                       style: TextStyle(
    //                           fontFamily: "Roboto",
    //                           fontSize: 22,
    //                           fontWeight: FontWeight.w500,
    //                           color: Colors.blue),
    //                     ),
    //                   ))
    //             ],
    //           ));
    // }
    // addNotification(message.data);
  });

  try {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (error) {}

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: const Color(0xFFF0F0F0),
          primaryColor: const Color(0xFF49299A),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline6:
                TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
            bodyText2: TextStyle(
              fontFamily: "Roboto",
            ),
          )),
      initialRoute: currentUser == null ? LoginScreen.route : MainScreen.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
        MainScreen.route: (context) => MainScreen(),
        NotificationScreen.route: (context) => const NotificationScreen(),
      },
    );
  }
}
