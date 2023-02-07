import 'package:access_control_system/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
      },
    );
  }
}
