import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Padding ListViewPageCard(key, Map<dynamic, dynamic> exercise) {
  final databaseReference = FirebaseDatabase.instance.ref().child("exercises");

  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: GestureDetector(
      onDoubleTap: () {
        databaseReference.child(key).remove();

        print("Pressed!!!");
      },
      child: Card(
        margin: const EdgeInsets.only(left: 50, right: 50),
        elevation: 20,
        shadowColor: const Color(0xff363F54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text("Name: ${exercise['name'] ?? ''}"),
            Text("Reps: ${exercise['reps'] ?? ''}"),
            Text("Sets: ${exercise['sets'] ?? ''}"),
            // Text("Date: ${exercise['Date'] ?? ''}"),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
