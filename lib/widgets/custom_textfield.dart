import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.emailController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController emailController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
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
            controller: emailController,
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: const TextStyle(
                    fontFamily: "Roboto", color: Colors.black45)),
          ),
        ),
      ),
    );
  }
}
