import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', 
        style: TextStyle(color: Colors.white)
        ),
          backgroundColor: Colors.blue,
        ),
      body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                hintText: 'Enter your e-mail here',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                hintText: 'Enter your password here',
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try{
                  final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  devtools.log(userCredentials.toString());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      devtools.log('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      devtools.log('The account already exists for that email.');
                    } else if (e.code == 'invalid-email') {
                      devtools.log('The email provided is invalid.');
                    }
                  }
                }, 
                child: const Text('Register',)
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/', 
                  (route) => false);
                }, 
                child: const Text('Already registered? Login here',)
                ),
            ],
          ),
    );
  }
}

