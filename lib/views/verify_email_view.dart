import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(children: [
            const Text('An email has been sent to your email address.'),
            const Text("If you haven't recieved the email, please check your spam folder, or send another email."),
            TextButton(onPressed: () async{
              await AuthService.firebase().sendEmailVerification();
            }, 
            child: const Text('Send email verification',
            )
            ),
            TextButton(
              onPressed: () async{
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
      ], 
      ),
    );
  }
}