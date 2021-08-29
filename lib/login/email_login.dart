import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/pages/home_page.dart';
import 'package:flutter_trip_ui/sign_up/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoggingIn = false;

  _logIn() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      var message = '';

      switch (e.code) {
        case 'invalid-email':
          message = 'The email you entered was invalid';
          break;
        case 'user-disabled':
          message = 'The user you tried to log into is disabled.';
          break;
        case 'user-not-found':
          message = 'The user you tried to log into is not found.';
          break;
        case 'wrong-password':
          message = 'The password you entered is wrong.';
          break;
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Login failed !'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ]);
        },
      );
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have A Trip',
                style: GoogleFonts.aclonica(
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 5.0),
            Text('Login',
                style: GoogleFonts.acme(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
            ),
            if (!isLoggingIn)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {
                        _logIn();
                      },
                      child: Text('Login')),
                ),
              ),
            if (isLoggingIn) ...[
              const SizedBox(height: 16.0),
              Center(child: CircularProgressIndicator())
            ],
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text('Sign Up')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
