import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/login/email_login.dart';
import 'package:flutter_trip_ui/widgets/submit_button.dart';
import 'package:flutter_trip_ui/widgets/user_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String imageUrl = '';
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20.0),
              UserImage(
                onFileChanged: (imageUrl) {
                  setState(() {
                    this.imageUrl = imageUrl;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              _TextField(
                label: 'Name',
                controller: _nameController,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 15),
              _TextField(
                  label: 'Email',
                  controller: _emailController,
                  validator: _requiredValidator),
              const SizedBox(height: 15),
              _TextField(
                label: 'Password',
                controller: _passwordController,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 15),
              _TextField(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                validator: _confirmPasswordValidator,
              ),
              const SizedBox(height: 15),
              if (loading) ...[
                Center(child: CircularProgressIndicator()),
              ],
              if (!loading) ...[
                SubmitButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _signUp();
                    }
                  },
                  padding: 16,
                ),
              ],
            ],
          )),
    );
  }

  Future _signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance.collection('users').add({
        'email': _emailController.text,
        'imageUrl': imageUrl,
        'name': _nameController.text,
      });

      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign up succeeded'),
                content: Text('Your account was created, you can now log in'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));

      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailLogin(),
          ));
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'This email is already in use';
        break;
      case 'invalid-email':
        messageToDisplay = 'The email you ented is invalid';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'This operation is not allowed';
        break;
      case 'weak-password':
        messageToDisplay = 'The password you entered is too weak';
        break;
      default:
        messageToDisplay = 'An unknown error occurred';
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Sign up failed'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'This field is required';
    }

    if (_passwordController.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }
  //
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool password;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const _TextField({
    required this.label,
    required this.controller,
    this.validator,
    this.password = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: password,
        validator: validator,
      ),
    );
  }
}
