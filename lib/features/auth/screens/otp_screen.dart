import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychat_app/colors.dart';
import 'package:mychat_app/features/auth/repository/auth_repository.dart';

class OTPScreen extends ConsumerWidget {
  static const routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authRepositoryProvider).verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your phone number"),
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("We have sent an SMS with the code "),
            SizedBox(
              width: deviceSize.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: '- - - - - -',
                    hintStyle: TextStyle(fontSize: 30)),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if(val.length ==6){
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
