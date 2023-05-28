import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gpt/Exercise.dart';

import 'Firebase_SignIn_Page.dart';

class FirebaseAuthPage extends StatefulWidget {
  const FirebaseAuthPage({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthPage> createState() => _FirebaseAuthPageState();
}

// final navigatorKey = GlobalKey<NavigatorState>();

class _FirebaseAuthPageState extends State<FirebaseAuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false; // Added isLoading variable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff363F54),
        title: const Text('New Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FirebaseSignInPage()));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text("Email:"),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    label: Text("Password:"),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  validator: (value) {},
                  controller: confirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    label: Text("Confirm Password:"),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff363F54)),
                onPressed: () {
                  signup(context);
                },
                child: const Text("Sign up"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> signup(BuildContext context) async {
    final NavigatorState navigator = Navigator.of(context);
    setState(() {
      isLoading =
          true; // Set isLoading to true to show CircularProgressIndicator
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      try {
        // final NavigatorState navigator =
        //     Navigator.of(context); // Capture the context
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        //Navigator.of(context).pop();
        navigator.pop();
        navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const ExerciseMain()),
        );
      } on FirebaseAuthException catch (e) {
        navigator.pop();
        print("not working");
        if (kDebugMode) {
          print(e);
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xff363F54),
          duration: Duration(seconds: 5),
          content: Text('LOGIN Failed'),
        ));
      }
    } else {
      navigator.pop();
      print("issue again");
      if (kDebugMode) {
        print("Passwords don't match");
      }
    }
    setState(() {
      isLoading =
          false; // Set isLoading to false after completing the sign-up process
    });

    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
