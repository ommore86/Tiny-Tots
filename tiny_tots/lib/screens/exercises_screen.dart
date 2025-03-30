import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:math';

class ExercisesScreen extends StatefulWidget {
  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    List<List<Map<String, dynamic>>> questionSets = [
      // Set 1 - Alphabets
      [
        {"question": "What comes after A?", "options": ["B", "C", "D", "E"], "answer": "B"},
        {"question": "Which letter is a vowel?", "options": ["B", "C", "E", "G"], "answer": "E"},
        {"question": "How many letters are in the English alphabet?", "options": ["24", "25", "26", "27"], "answer": "26"},
        {"question": "Which letter comes before Z?", "options": ["X", "Y", "V", "W"], "answer": "Y"},
        {"question": "What is the 5th letter in the alphabet?", "options": ["D", "E", "F", "G"], "answer": "E"},
      ],
      // Set 2 - Numbers
      [
        {"question": "What comes after 5?", "options": ["4", "5", "6", "7"], "answer": "6"},
        {"question": "What is 3+2?", "options": ["4", "5", "6", "7"], "answer": "5"},
        {"question": "Which number is even?", "options": ["3", "5", "8", "9"], "answer": "8"},
        {"question": "How many fingers do you have?", "options": ["5", "10", "15", "20"], "answer": "10"},
        {"question": "Which number is greater: 25 or 52?", "options": ["25", "52", "Both same", "None"], "answer": "52"},
      ],
      // Set 3 - Shapes
      [
        {"question": "Which shape has 4 equal sides?", "options": ["Circle", "Square", "Triangle", "Rectangle"], "answer": "Square"},
        {"question": "Which shape has no corners?", "options": ["Square", "Triangle", "Circle", "Rectangle"], "answer": "Circle"},
        {"question": "How many sides does a hexagon have?", "options": ["5", "6", "7", "8"], "answer": "6"},
        {"question": "What is a three-sided shape called?", "options": ["Square", "Triangle", "Circle", "Pentagon"], "answer": "Triangle"},
        {"question": "What is the shape of a wheel?", "options": ["Rectangle", "Circle", "Oval", "Square"], "answer": "Circle"},
      ],
      // Set 4 - Colors
      [
        {"question": "What color is a banana?", "options": ["Blue", "Red", "Yellow", "Green"], "answer": "Yellow"},
        {"question": "What color is the sky?", "options": ["Red", "Blue", "Green", "Yellow"], "answer": "Blue"},
        {"question": "What color is a strawberry?", "options": ["Red", "Blue", "Green", "Pink"], "answer": "Red"},
        {"question": "Which color is made by mixing red and blue?", "options": ["Orange", "Purple", "Green", "Yellow"], "answer": "Purple"},
        {"question": "What color is chocolate?", "options": ["White", "Black", "Brown", "Green"], "answer": "Brown"},
      ],
      // Set 5 - Animals
      [
        {"question": "Which animal barks?", "options": ["Cat", "Dog", "Cow", "Horse"], "answer": "Dog"},
        {"question": "Which animal is the largest land animal?", "options": ["Lion", "Tiger", "Elephant", "Deer"], "answer": "Elephant"},
        {"question": "Which animal lives in water?", "options": ["Dog", "Parrot", "Shark", "Lion"], "answer": "Shark"},
        {"question": "Which animal has a trunk?", "options": ["Tiger", "Monkey", "Elephant", "Horse"], "answer": "Elephant"},
        {"question": "Which animal gives us milk?", "options": ["Horse", "Goat", "Lion", "Cow"], "answer": "Cow"},
      ],
    ];

    questionSets.shuffle();
    questions = questionSets.first.take(10).toList();
  }

  void _submitAnswer(String selectedAnswer) {
    setState(() {
      if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
        score += 1;
        feedbackMessage = "✅ Correct!";
        feedbackColor = Colors.green;
      } else {
        feedbackMessage = "❌ Wrong! The correct answer is ${questions[currentQuestionIndex]['answer']}";
        feedbackColor = Colors.red;
      }

      if (currentQuestionIndex < questions.length - 1) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            currentQuestionIndex++;
            feedbackMessage = "";
            feedbackColor = Colors.transparent;
          });
        });
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            quizCompleted = true;
          });
          _saveScore();
        });
      }
    });
  }

  Future<void> _saveScore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection("users").doc(user.uid).update({
        "score": score,
        "lastExerciseDate": FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise Time!")),
      body: quizCompleted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Quiz Completed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text("Your Score: $score/${questions.length}", style: TextStyle(fontSize: 20)),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Score: $score", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  SizedBox(height: 10),
                  Text(
                    "Q${currentQuestionIndex + 1}: ${questions[currentQuestionIndex]['question']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: questions[currentQuestionIndex]['options'].map<Widget>((option) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5), // Added spacing between options
                        child: ElevatedButton(
                          onPressed: () => _submitAnswer(option),
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    feedbackMessage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: feedbackColor),
                  ),
                ],
              ),
            ),
    );
  }
}