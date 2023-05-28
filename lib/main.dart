import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Firebase_SignIn_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // navigatorKey: navigatorKey,
      home: Scaffold(
        body: FirebaseSignInPage(),
      ),
    );
  }
}
