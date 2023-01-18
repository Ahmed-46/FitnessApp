import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gpt/ListOfExcises.dart';

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
  final _formKey = GlobalKey<FormState>();
  String _exerciseName = "";
  int _reps = 0;
  int _sets = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Exercises"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExercisesPage()));
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
                  decoration: const InputDecoration(
                    labelText: 'Exercise Name:',
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
                  onSaved: (value) => _exerciseName = value!,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of reps:',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.number,
                  controller: repsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of reps:';
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
                  decoration: const InputDecoration(
                    labelText: 'Number of sets:',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.number,
                  controller: setsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of sets';
                    }
                    return null;
                  },
                  onSaved: (value) => _sets = int.parse(value!),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      database.ref().child("exercises").push().set({
        "name": _exerciseName,
        "reps": _reps,
        "sets": _sets,
      });
      print("ITS DONE!!!");
      // Clear the text fields
      exerciseController.clear();
      repsController.clear();
      setsController.clear();

      // Navigator.pop(context);
    }
  }
}
