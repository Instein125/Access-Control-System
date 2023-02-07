import 'package:flutter/material.dart';

import '../widgets/custom_textbutton.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool passwordVisible = false;

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
              Container(
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
              Container(
                child: Column(
                  children: [
                    CustomTextField(
                      emailController: emailController,
                      hintText: "Email",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomPasswordField(context),
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
                    CustomTextButton(size: size, title: "Sign In"),
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
                            onPressed: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CustomPasswordField(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 2.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        child: Center(
          child: TextField(
            controller: passwordController,
            obscureText: passwordVisible,
            decoration: InputDecoration(
                hintText: "Password",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                      passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black45),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                hintStyle: const TextStyle(
                    fontFamily: "Roboto", color: Colors.black45)),
          ),
        ),
      ),
    );
  }
}
