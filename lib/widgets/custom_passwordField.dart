import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField({
    Key? key,
    required this.passwordController,
    required this.passwordVisible,
    required this.title,
  }) : super(key: key);

  final TextEditingController passwordController;
  bool passwordVisible;
  final String title;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: TextField(
        controller: widget.passwordController,
        style: Theme.of(context).textTheme.bodyText2,
        obscureText: widget.passwordVisible,
        decoration: InputDecoration(
            labelText: widget.title,
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
            suffixIcon: IconButton(
              icon: Icon(
                  widget.passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black45),
              onPressed: () {
                setState(
                  () {
                    widget.passwordVisible = !widget.passwordVisible;
                  },
                );
              },
            ),
            labelStyle:
                const TextStyle(fontFamily: "Roboto", color: Colors.black45)),
      ),
    );
  }
}
