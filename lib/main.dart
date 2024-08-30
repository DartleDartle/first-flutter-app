import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/firebase_options.dart';
import 'package:firstapp/views/login_view.dart';
import 'package:firstapp/views/register_view.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ));
}

  class HomePage  extends StatelessWidget {
  const HomePage ({super.key});

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                    ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
               /* final user = FirebaseAuth.instance.currentUser;
                print(user);
                if (user?.emailVerified ?? false) {
                  return Text('Done');
                } else {
                  return const VerifyEmailView();
                } */
                return const LoginView();
              default:
                return const Text('Loading...');
            }
          } 
        ),
      );
    }   
  }

  class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        const Text('Please verify your email address:'),
        TextButton(onPressed: () async{
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
        }, child: const Text('Send email verification'))
      ], 
    );
  }
}