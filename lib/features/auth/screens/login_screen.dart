// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychat_app/colors.dart';
import 'package:mychat_app/common/utils/utils.dart';
import 'package:mychat_app/common/widgets/custom_button.dart';
import 'package:mychat_app/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      //Provider ref : Interact provider with provider
      //Widget ref : makes widget  interact wwith provider
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
      //upper line is basically Provider.of(context, listen : false);
    } else {
      showSnackBar(context: context, content: "Fill out all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your phone number"),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("MyChat will need to verify your phone number."),
              const SizedBox(
                height: 10,
              ),
              TextButton(onPressed: pickCountry, child: Text("Pick Country")),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(hintText: 'phone number'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: deviceSize.height * 0.6,
              ),
              SizedBox(
                width: 90,
                child: CustomButton(text: "NEXT", onPressed: sendPhoneNumber),
              )
            ],
          ),
        ),
      ),
    );
  }
}
