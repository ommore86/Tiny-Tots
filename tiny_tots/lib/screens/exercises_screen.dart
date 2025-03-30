import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';

class ExercisesScreen extends StatefulWidget {
  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();

  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    setState(() {
      isLoading = true;
    });
    
    // All question sets combined
    List<Map<String, dynamic>> allQuestions = [
      // Animals
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/dog.png", "options": ["Dog", "Cat", "Bird"], "answer": "Dog", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/elephant.png", "options": ["Elephant", "Lion", "Monkey"], "answer": "Elephant", "category": "Animals"},
      {"type": "sound", "question": "What animal makes this sound?", "sound": "assets/sounds/cat.mp3", "options": ["Cat", "Dog", "Cow"], "answer": "Cat", "category": "Animals"},
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/bird.png", "options": ["Bird", "Fish", "Snake"], "answer": "Bird", "category": "Animals"},
      {"type": "sound", "question": "Listen and guess!", "sound": "assets/sounds/cow.mp3", "options": ["Cow", "Horse", "Sheep"], "answer": "Cow", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/fish.png", "options": ["Fish", "Rabbit", "Tiger"], "answer": "Fish", "category": "Animals"},
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/lion.png", "options": ["Lion", "Bear", "Deer"], "answer": "Lion", "category": "Animals"},
      {"type": "sound", "question": "What animal is this?", "sound": "assets/sounds/horse.mp3", "options": ["Horse", "Pig", "Duck"], "answer": "Horse", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/rabbit.png", "options": ["Rabbit", "Mouse", "Fox"], "answer": "Rabbit", "category": "Animals"},
      {"type": "sound", "question": "Listen and guess!", "sound": "assets/sounds/duck.mp3", "options": ["Duck", "Goose", "Chicken"], "answer": "Duck", "category": "Animals"},
      
      // Colors
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/red.png", "options": ["Red", "Blue", "Green"], "answer": "Red", "category": "Colors"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/blue.png", "options": ["Blue", "Yellow", "Pink"], "answer": "Blue", "category": "Colors"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/yellow.png", "options": ["Yellow", "Orange", "Purple"], "answer": "Yellow", "category": "Colors"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/green.png", "options": ["Green", "Brown", "Red"], "answer": "Green", "category": "Colors"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/purple.png", "options": ["Purple", "Pink", "Blue"], "answer": "Purple", "category": "Colors"},
      
      // Shapes
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/circle.png", "options": ["Circle", "Square", "Triangle"], "answer": "Circle", "category": "Shapes"},
      {"type": "image", "question": "Guess the shape!", "image": "assets/images/shapes/square.png", "options": ["Square", "Rectangle", "Oval"], "answer": "Square", "category": "Shapes"},
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/triangle.png", "options": ["Triangle", "Circle", "Hexagon"], "answer": "Triangle", "category": "Shapes"},
      
      // Fruits
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/apple.png", "options": ["Apple", "Banana", "Orange"], "answer": "Apple", "category": "Fruits"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/banana.png", "options": ["Banana", "Grape", "Mango"], "answer": "Banana", "category": "Fruits"},
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/orange.png", "options": ["Orange", "Apple", "Pear"], "answer": "Orange", "category": "Fruits"},
      
      // Numbers
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/1.png", "options": ["1", "2", "3"], "answer": "1", "category": "Numbers"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/2.png", "options": ["2", "3", "4"], "answer": "2", "category": "Numbers"},
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/3.png", "options": ["3", "1", "5"], "answer": "3", "category": "Numbers"},
      
      // Foods
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/pizza.png", "options": ["Pizza", "Burger", "Cake"], "answer": "Pizza", "category": "Foods"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/burger.png", "options": ["Burger", "Sandwich", "Ice Cream"], "answer": "Burger", "category": "Foods"},
    ];

    // Shuffle all questions and take first 10
    allQuestions.shuffle();
    questions = allQuestions.take(10).toList();

    setState(() {
      isLoading = false;
    });
  }

  void _submitAnswer(String selectedAnswer) {
    setState(() {
      if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
        score += 1;
        feedbackMessage = "✅ Yay! Good job!";
        feedbackColor = Colors.green;
      } else {
        feedbackMessage = "❌ Oops! It's ${questions[currentQuestionIndex]['answer']}";
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

  void _playSound(String soundPath) {
    _audioPlayer.play(AssetSource(soundPath));
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
      feedbackMessage = "";
      feedbackColor = Colors.transparent;
    });
    _generateQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fun Learning Time!", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade300, Colors.blue.shade200],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : quizCompleted
                ? Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.celebration, size: 60, color: Colors.amber),
                          SizedBox(height: 20),
                          Text("All Done!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          SizedBox(height: 20),
                          Text("Your Score:", style: TextStyle(fontSize: 24, color: Colors.blueGrey)),
                          SizedBox(height: 10),
                          Text("$score/${questions.length}", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.orange)),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _restartQuiz,
                            child: Text("Play Again", style: TextStyle(fontSize: 20)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Stars: $score",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Category: ${questions[currentQuestionIndex]['category']}",
                                style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                questions[currentQuestionIndex]['question'],
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        if (questions[currentQuestionIndex]['type'] == "image")
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              questions[currentQuestionIndex]['image'],
                              height: 150,
                            ),
                          ),
                        if (questions[currentQuestionIndex]['type'] == "sound")
                          ElevatedButton(
                            onPressed: () => _playSound(questions[currentQuestionIndex]['sound']),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.play_arrow),
                                SizedBox(width: 5),
                                Text("Play Sound"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        SizedBox(height: 30),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: questions[currentQuestionIndex]['options'].map<Widget>((option) {
                            return ElevatedButton(
                              onPressed: () => _submitAnswer(option),
                              child: Text(
                                option,
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple.shade400,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: feedbackColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            feedbackMessage,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: feedbackColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          child: LinearProgressIndicator(
                            value: (currentQuestionIndex + 1) / questions.length,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            "Question ${currentQuestionIndex + 1} of ${questions.length}",
                            style: TextStyle(color: Colors.white, fontSize: 12), // Reduced font size
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}