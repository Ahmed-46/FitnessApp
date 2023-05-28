import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gpt/list_of_excises.dart';

class ExerciseMain extends StatefulWidget {
  const ExerciseMain({super.key});

  @override
  _ExerciseMainState createState() => _ExerciseMainState();
}

class _ExerciseMainState extends State<ExerciseMain> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController exerciseController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController setsController = TextEditingController();

  // DateTime _selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  String exerciseName = "";
  int _reps = 0;
  int _sets = 0;

  // String chosenDate = "";

  @override
  Widget build(BuildContext context) {
    // var day = _selectedDate.day;
    // var month = _selectedDate.month;
    // String mydate = "Date : $day of $month".toString();
    // chosenDate = mydate;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff363F54),
        title: const Text("Exercises"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExercisesPage()));
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 50, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name of Exercise: ',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: exerciseController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the exercise name';
                    }
                    return null;
                  },
                  onSaved: (value) => exerciseName = value!,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of Reps:(kg)',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: repsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Number of Reps';
                    }
                    return null;
                  },
                  onSaved: (value) => _reps = int.parse(value!),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of Sets: ',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: setsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Number of Sets';
                    }
                    return null;
                  },
                  onSaved: (value) => _sets = int.parse(value!),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xff39486b)),
              //   child: const Text("Select Date"),
              //   onPressed: () async {
              //     final date = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(2000),
              //         lastDate: DateTime(2025));
              //     if (date != null) {
              //       setState(() {
              //         var day = _selectedDate.day;
              //         var month = _selectedDate.month;
              //         String mydate = "$day th of $month".toString();
              //         chosenDate = mydate;
              //
              //         print(chosenDate);
              //       });
              //     }
              //   },
              // ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff363F54)),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        database.ref().child("exercises").push().set({
          "name": exerciseName,
          "reps": _reps,
          "sets": _sets,
          // "Date": chosenDate,
        });

        // Clear the text fields
        exerciseController.clear();
        repsController.clear();
        setsController.clear();
      }
    }
  }
}
