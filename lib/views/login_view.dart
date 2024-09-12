import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/auth_exceptions.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:firstapp/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login', 
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
                    await AuthService.firebase().logIn(
                      email: email, 
                      password: password,
                      );

                  final user = AuthService.firebase().currentUser;
                  if(user?.isEmailVerified ?? false){
                    // user email verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute, 
                      (route) => false
                    );
                  } else {
                    // user email not verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute, 
                        (route) => false
                      );
                    }
                  
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'No user found for that email',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Wrong password provided for that user'
                    );
                  } on InvalidCredentialsAuthException {
                    await showErrorDialog(
                      context,
                      'Invalid credentials provided. Please check your email and password.'
                      );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context, 
                      'Authentication error.',
                      );
                  }                  
                }, 
                child: const Text('Login',)
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, 
                    (route) => false);
                },
                child: const Text('Not registered yet? Create an account'),
              )
            ],
          ),
    );
  } 
}

