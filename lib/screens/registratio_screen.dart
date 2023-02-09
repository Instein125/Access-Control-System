// ignore_for_file: use_build_context_synchronously

import 'package:access_control_system/screens/login_screen.dart';
import 'package:access_control_system/widgets/loading_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_passwordField.dart';
import '../widgets/custom_textbutton.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/snackbar.dart';

class RegistrationScreen extends StatefulWidget {
  static const String route = "/registration_screen";

  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var fullnameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  Future registerUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => const LoadingAnimation()),
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        final newUserRef =
            FirebaseFirestore.instance.collection("users").doc(user.uid);

        final userData = {
          "fullname": fullnameController.text,
          "email": emailController.text,
          "doorStatus": "close",
          'lightStatus': "off",
          "smokePercent": "0.0",
        };

        await newUserRef.set(userData);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.route, (route) => false);
      }
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
                  height: size.height * 0.25,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/Icon_doorKnob.png",
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                      color: const Color.fromARGB(255, 207, 134, 26),
                    ),
                  )),
              Column(
                children: [
                  CustomTextField(
                    emailController: fullnameController,
                    hintText: "Full Name",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  CustomPasswordField(
                      passwordController: confirmPasswordController,
                      passwordVisible: true,
                      title: "Confirm Password"),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextButton(
                    size: size,
                    title: "Sign Up",
                    onPressed: () async {
                      //checking connectivity to network. funtion needs to be async
                      var connectivityResult =
                          await Connectivity().checkConnectivity();
                      if (connectivityResult != ConnectivityResult.mobile &&
                          connectivityResult != ConnectivityResult.wifi) {
                        showSnackBar("No internet connection!", context);
                        return;
                      }

                      if (fullnameController.text.length <= 3) {
                        showSnackBar("Please enter a valid name!", context);
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

                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        showSnackBar("Password doesnot match", context);
                        return;
                      }

                      registerUser();
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
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginScreen.route, (route) => false);
                          },
                          child: Text(
                            "Sign In",
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
