// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mychat_app/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: tabColor, minimumSize: Size(double.infinity, 50)),
        child: Text(
          text,
          style: TextStyle(color: blackColor),
        ));
  }
}
