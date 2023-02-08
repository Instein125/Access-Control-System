import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.size,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String title;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 25),
        ),
      ),
    );
  }
}
