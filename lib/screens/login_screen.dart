// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:access_control_system/screens/mainscreen.dart';
import 'package:access_control_system/screens/registratio_screen.dart';
import 'package:access_control_system/widgets/custom_passwordField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textbutton.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loading_animation.dart';
import '../widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  Future login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => const LoadingAnimation()),
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final userRef =
            FirebaseFirestore.instance.collection("users").doc(user.uid);
        userRef.get().then(
          (DocumentSnapshot doc) {
            //this is user data
          },
          onError: (e) {},
        );
      }
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showSnackBar(e.message.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * 0.35,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/Icon_doorKnob.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                      color: const Color.fromARGB(255, 207, 134, 26),
                    ),
                  )),
              Column(
                children: [
                  CustomTextField(
                    emailController: emailController,
                    hintText: "Email",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomPasswordField(
                      passwordController: passwordController,
                      passwordVisible: true,
                      title: "Password"),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10, top: 12),
                        child: Text(
                          "Recover password",
                          style: TextStyle(
                              fontFamily: 'Roboto', color: Colors.black54),
                        ),
                      )),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextButton(
                    size: size,
                    title: "Sign In",
                    onPressed: () async {
                      //checking connectivity to network. funtion needs to be async
                      var connectivityResult =
                          await Connectivity().checkConnectivity();
                      if (connectivityResult != ConnectivityResult.mobile &&
                          connectivityResult != ConnectivityResult.wifi) {
                        showSnackBar("No internet connection!", context);
                        return;
                      }

                      if (!emailController.text.contains('@')) {
                        showSnackBar("Please enter a valid email!", context);
                        return;
                      }

                      if (passwordController.text.length <= 6) {
                        showSnackBar("Password must be more than 6 characters!",
                            context);
                        return;
                      }

                      login();
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 1,
                    color: Theme.of(context).primaryColor,
                    width: size.width * 0.6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Not a member?",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RegistrationScreen.route, (route) => false);
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
