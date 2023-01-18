import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gpt/ExercisesCloud.dart';

class ExercisesPage extends StatefulWidget {
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final databaseReference = FirebaseDatabase.instance.ref().child("exercises");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Exercises List'),
      ),
      body: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.snapshot.value != null) {
            List<dynamic> _exerciseList =
            snapshot.data.snapshot.value.values.toList();

            return ListView.builder(

                itemCount: _exerciseList.length,
                itemBuilder: (context, index) {
                  final exercise =
                  _exerciseList[index] as Map<dynamic, dynamic>;
                  final key = snapshot.data.snapshot.value.keys.toList()[index];
                  return ExercsieListview(key, exercise);
                });
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }


}
