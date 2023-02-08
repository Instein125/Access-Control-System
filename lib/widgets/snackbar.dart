import 'package:flutter/material.dart';

void showSnackBar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      backgroundColor: const Color.fromRGBO(244, 67, 54, 0.9),
      duration: const Duration(seconds: 1),
    ),
  );
}
