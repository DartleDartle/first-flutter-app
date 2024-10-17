import 'package:firstapp/services/auth/bloc/auth_bloc.dart';
import 'package:firstapp/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Column(
        children: [
          const Text('An email has been sent to your email address.'),
          const Text(
              "If you haven't recieved the email, please check your spam folder, or send another email."),
          TextButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text(
                'Send email verification',
              )),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
