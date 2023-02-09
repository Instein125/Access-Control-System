import 'package:access_control_system/screens/login_screen.dart';
import 'package:access_control_system/screens/mainscreen.dart';
import 'package:access_control_system/screens/registratio_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
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
      },
    );
  }
}
