// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mychat_app/colors.dart';
import 'package:mychat_app/common/widgets/custom_button.dart';
import 'package:mychat_app/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: deviceSize.height * 0.05,
          ),
          Text(
            "Welcome to MyChat",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: deviceSize.height / 9,
          ),
          Image.asset(
            'assets/bg.png',
            height: 340,
            width: 340,
            color: tabColor,
          ),
          SizedBox(
            height: deviceSize.height / 9,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Read our Privacy Policy. Tap 'Agree and continue' to accept the Terms of Service.",
              style: TextStyle(
                color: greyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: deviceSize.width * 0.75,
            child: CustomButton(
              text: "AGREE AND CONTINUE",
              onPressed: () => navigateToLoginScreen(context),
            ),
          )
        ],
      )),
    );
  }
}
