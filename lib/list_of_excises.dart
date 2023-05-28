import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gpt/ExercisesCloud.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override

  /// I REMOVED THE _ THAT WAS BEFORE ExercisesPageState
  ExercisesPageState createState() => ExercisesPageState();
}

class ExercisesPageState extends State<ExercisesPage> {
  final databaseReference = FirebaseDatabase.instance.ref().child("exercises");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff363F54),
        title: const Text('Exercises List'),
      ),
      body: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.snapshot.value != null) {
            List<dynamic> exerciseList =
                snapshot.data.snapshot.value.values.toList();

            return ListView.builder(
                itemCount: exerciseList.length,
                itemBuilder: (context, index) {
                  final exercise = exerciseList[index] as Map<dynamic, dynamic>;
                  final key = snapshot.data.snapshot.value.keys.toList()[index];
                  return ListViewPageCard(key, exercise);
                });
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
