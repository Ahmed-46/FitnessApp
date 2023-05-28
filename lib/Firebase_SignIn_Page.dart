import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Exercise.dart';
import 'FirebaseSignUpPage.dart';

class FirebaseSignInPage extends StatefulWidget {
  const FirebaseSignInPage({Key? key}) : super(key: key);

  @override
  State<FirebaseSignInPage> createState() => _FirebaseSignInPageState();
}

class _FirebaseSignInPageState extends State<FirebaseSignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(12, 172, 157, 255), //
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6, top: 200),
              child: CircleAvatar(
                radius: 90,
                child: ClipOval(
                  child: Image.asset("Images/olarn.png"),
                ),
                // CircleAvatar(
                //   radius: 50,
                //   child: Image.asset("Images/olarn.png"),
                // ),
                // SizedBox(
                //   height: 400,
                //   width: 300,
                //   child: Image.asset("Images/olarn.png"),
                // ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                validator: (value) {
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("Email."),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                validator: (value) {
                  return null;
                },
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                logIn(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff363F54)), //0xFF5E35B1
              child: const Text("Sign in"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a user?"),
                RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FirebaseAuthPage(),
                                  ),
                                );
                                if (kDebugMode) {
                                  print("tapped");
                                }
                              })
                      ]),
                ),
                // Text("LOG IN",
                //     style: TextStyle(
                //       color: Colors.teal,
                //     )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logIn(BuildContext context) async {
    final NavigatorState navigator = Navigator.of(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      navigator.pop();
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ExerciseMain(),
        ),
      );
    } on FirebaseAuthException {
      navigator.pop();
      if (kDebugMode) {
        print("not working@@@@@@@@@@@");
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xff363F54),
        duration: Duration(seconds: 5),
        content: Text('LOGIN Failed'),
      ));
    }
    emailController.clear();
    passwordController.clear();
  }
}
