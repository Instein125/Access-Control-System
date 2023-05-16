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
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextField(
        controller: emailController,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            labelText: hintText,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(18.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelStyle:
                const TextStyle(fontFamily: "Roboto", color: Colors.black45)),
      ),
    );
  }
}
