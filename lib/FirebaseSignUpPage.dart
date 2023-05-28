import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gpt/Exercise.dart';

class FirebaseAuthPage extends StatefulWidget {
  const FirebaseAuthPage({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthPage> createState() => _FirebaseAuthPageState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _FirebaseAuthPageState extends State<FirebaseAuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
        final NavigatorState navigator =
            Navigator.of(context); // Capture the context
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
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      if (kDebugMode) {
        print("Passwords don't match");
      }
    }

    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
