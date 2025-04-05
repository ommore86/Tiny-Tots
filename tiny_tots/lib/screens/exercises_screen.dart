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
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/dog.png", "options": ["Cat", "Dog", "Bird"], "answer": "Dog", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/elephant.png", "options": ["Monkey", "Lion", "Elephant"], "answer": "Elephant", "category": "Animals"},
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/bird.png", "options": ["Bird", "Fish", "Snake"], "answer": "Bird", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/fish.png", "options": ["Tiger", "Rabbit", "Fish"], "answer": "Fish", "category": "Animals"},
      {"type": "image", "question": "Guess the animal!", "image": "assets/images/animals/lion.png", "options": ["Bear", "Lion", "Deer"], "answer": "Lion", "category": "Animals"},
      {"type": "image", "question": "Who is this?", "image": "assets/images/animals/rabbit.png", "options": ["Rabbit", "Mouse", "Fox"], "answer": "Rabbit", "category": "Animals"},
      
      // Colors
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/red.png", "options": ["Blue", "Red", "Green"], "answer": "Red", "category": "Colors"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/blue.png", "options": ["Pink", "Yellow", "Blue"], "answer": "Blue", "category": "Colors"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/yellow.png", "options": ["Yellow", "Orange", "Purple"], "answer": "Yellow", "category": "Colors"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/green.png", "options": ["Brown", "Green", "Red"], "answer": "Green", "category": "Colors"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/purple.png", "options": ["Purple", "Pink", "Blue"], "answer": "Purple", "category": "Colors"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/orange.png", "options": ["Red", "Orange", "Yellow"], "answer": "Orange"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/pink.png", "options": ["Green", "Purple", "Pink"], "answer": "Pink"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/brown.png", "options": ["Blue", "Black", "Brown"], "answer": "Brown"},
      {"type": "image", "question": "What color is this?", "image": "assets/images/colors/black.png", "options": ["Black", "White", "Red"], "answer": "Black"},
      {"type": "image", "question": "Guess the color!", "image": "assets/images/colors/white.png", "options": ["White", "Gray", "Yellow"], "answer": "White"},


      // Shapes
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/circle.png", "options": ["Circle", "Square", "Triangle"], "answer": "Circle", "category": "Shapes"},
      {"type": "image", "question": "Guess the shape!", "image": "assets/images/shapes/square.png", "options": ["Rectangle", "Square", "Oval"], "answer": "Square", "category": "Shapes"},
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/triangle.png", "options": ["Hexagon", "Circle", "Triangle"], "answer": "Triangle", "category": "Shapes"},
      {"type": "image", "question": "Guess the shape!", "image": "assets/images/shapes/rectangle.png", "options": ["Rectangle", "Square", "Star"], "answer": "Rectangle"},
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/star.png", "options": ["Circle", "Star", "Pentagon"], "answer": "Star"},
      {"type": "image", "question": "Guess the shape!", "image": "assets/images/shapes/pentagon.png", "options": ["Triangle", "Hexagon", "Pentagon"], "answer": "Pentagon"},
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/hexagon.png", "options": ["Hexagon", "Square", "Oval"], "answer": "Hexagon"},
      {"type": "image", "question": "Guess the shape!", "image": "assets/images/shapes/oval.png", "options": ["Star", "Oval", "Rectangle"], "answer": "Oval"},
      {"type": "image", "question": "What shape is this?", "image": "assets/images/shapes/diamond.png", "options": ["Triangle", "Star", "Diamond"], "answer": "Diamond"},


      // Fruits
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/apple.png", "options": ["Apple", "Banana", "Orange"], "answer": "Apple", "category": "Fruits"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/banana.png", "options": ["Grape", "Banana", "Mango"], "answer": "Banana", "category": "Fruits"},
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/orange.png", "options": ["Pear", "Apple", "Orange"], "answer": "Orange", "category": "Fruits"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/grape.png", "options": ["Grape", "Cherry", "Strawberry"], "answer": "Grape"},
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/mango.png", "options": ["Pineapple", "Mango", "Peach"], "answer": "Mango"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/strawberry.png", "options": ["Blueberry", "Raspberry", "Strawberry"], "answer": "Strawberry"},
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/pineapple.png", "options": ["Pineapple", "Melon", "Kiwi"], "answer": "Pineapple"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/pear.png", "options": ["Apple", "Pear", "Plum"], "answer": "Pear"},
      {"type": "image", "question": "What fruit is this?", "image": "assets/images/fruits/cherry.png", "options": ["Berry", "Grape", "Cherry"], "answer": "Cherry"},
      {"type": "image", "question": "Guess the fruit!", "image": "assets/images/fruits/kiwi.png", "options": ["Kiwi", "Mango", "Orange"], "answer": "Kiwi"},


      // Numbers
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/1.png", "options": ["1", "2", "3"], "answer": "1", "category": "Numbers"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/2.png", "options": ["3", "2", "4"], "answer": "2", "category": "Numbers"},
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/3.png", "options": ["5", "1", "3"], "answer": "3", "category": "Numbers"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/4.png", "options": ["4", "2", "6"], "answer": "4"},
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/5.png", "options": ["3", "5", "7"], "answer": "5"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/6.png", "options": ["8", "4", "6"], "answer": "6"},
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/7.png", "options": ["5", "7", "9"], "answer": "7"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/8.png", "options": ["10", "6", "8"], "answer": "8"},
      {"type": "image", "question": "How many are there?", "image": "assets/numbers/9.png", "options": ["9", "7", "1"], "answer": "9"},
      {"type": "image", "question": "Count them!", "image": "assets/numbers/10.png", "options": ["2", "8", "10"], "answer": "10"},

      // Foods
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/pizza.png", "options": ["Pizza", "Burger", "Cake"], "answer": "Pizza", "category": "Foods"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/burger.png", "options": ["Sandwich", "Burger", "Ice Cream"], "answer": "Burger", "category": "Foods"},
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/cake.png", "options": ["Pizza", "Cookie", "Cake"], "answer": "Cake"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/icecream.png", "options": ["Ice Cream", "Candy", "Bread"], "answer": "Ice Cream"},
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/sandwich.png", "options": ["Burger", "Sandwich", "Pasta"], "answer": "Sandwich"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/cookie.png", "options": ["Donut", "Cake", "Cookie"], "answer": "Cookie"},
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/pasta.png", "options": ["Pasta", "Pizza", "Soup"], "answer": "Pasta"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/donut.png", "options": ["Cookie", "Donut", "Bread"], "answer": "Donut"},
      {"type": "image", "question": "What food is this?", "image": "assets/images/foods/bread.png", "options": ["Cake", "Sandwich", "Bread"], "answer": "Bread"},
      {"type": "image", "question": "Guess the food!", "image": "assets/images/foods/soup.png", "options": ["Soup", "Pasta", "Pizza"], "answer": "Soup"},

      // Vehicles
      {"type": "image", "question": "What vehicle is this?", "image": "assets/images/vehicles/car.png", "options": ["Car", "Bus", "Train"], "answer": "Car"},
      {"type": "image", "question": "Guess the vehicle!", "image": "assets/images/vehicles/bus.png", "options": ["Bus", "Truck", "Boat"], "answer": "Bus"},
      {"type": "image", "question": "What vehicle is this?", "image": "assets/images/vehicles/train.png", "options": ["Train", "Plane", "Car"], "answer": "Train"},
      {"type": "image", "question": "Guess the vehicle!", "image": "assets/images/vehicles/plane.png", "options": ["Plane", "Helicopter", "Ship"], "answer": "Plane"},
      {"type": "image", "question": "What vehicle is this?", "image": "assets/images/vehicles/boat.png", "options": ["Boat", "Bus", "Bicycle"], "answer": "Boat"},
      {"type": "image", "question": "Guess the vehicle!", "image": "assets/images/vehicles/truck.png", "options": ["Truck", "Car", "Train"], "answer": "Truck"},
      {"type": "image", "question": "What vehicle is this?", "image": "assets/images/vehicles/bicycle.png", "options": ["Bicycle", "Scooter", "Plane"], "answer": "Bicycle"},
      {"type": "image", "question": "Guess the vehicle!", "image": "assets/images/vehicles/helicopter.png", "options": ["Helicopter", "Plane", "Boat"], "answer": "Helicopter"},
      {"type": "image", "question": "What vehicle is this?", "image": "assets/images/vehicles/ship.png", "options": ["Ship", "Bus", "Truck"], "answer": "Ship"},
      {"type": "image", "question": "Guess the vehicle!", "image": "assets/images/vehicles/scooter.png", "options": ["Scooter", "Bicycle", "Car"], "answer": "Scooter"},

      // Toys
      {"type": "image", "question": "What toy is this?", "image": "assets/images/toys/ball.png", "options": ["Ball", "Doll", "Car"], "answer": "Ball"},
      {"type": "image", "question": "Guess the toy!", "image": "assets/images/toys/doll.png", "options": ["Doll", "Teddy", "Robot"], "answer": "Doll"},
      {"type": "image", "question": "What toy is this?", "image": "assets/images/toys/car.png", "options": ["Car", "Plane", "Ball"], "answer": "Car"},
      {"type": "image", "question": "Guess the toy!", "image": "assets/images/toys/teddy.png", "options": ["Teddy", "Doll", "Puzzle"], "answer": "Teddy"},
      {"type": "image", "question": "What toy is this?", "image": "assets/images/toys/plane.png", "options": ["Plane", "Car", "Boat"], "answer": "Plane"},
      {"type": "image", "question": "Guess the toy!", "image": "assets/images/toys/robot.png", "options": ["Robot", "Teddy", "Ball"], "answer": "Robot"},
      {"type": "image", "question": "What toy is this?", "image": "assets/images/toys/puzzle.png", "options": ["Puzzle", "Doll", "Car"], "answer": "Puzzle"},
      {"type": "image", "question": "Guess the toy!", "image": "assets/images/toys/boat.png", "options": ["Boat", "Plane", "Teddy"], "answer": "Boat"},
      {"type": "image", "question": "What toy is this?", "image": "assets/images/toys/kite.png", "options": ["Kite", "Ball", "Robot"], "answer": "Kite"},
      {"type": "image", "question": "Guess the toy!", "image": "assets/images/toys/train.png", "options": ["Train", "Car", "Puzzle"], "answer": "Train"},

      // Emotions
      {"type": "image", "question": "How does this face feel?", "image": "assets/images/emotions/happy.png", "options": ["Happy", "Sad", "Angry"], "answer": "Happy"},
      {"type": "image", "question": "Guess the feeling!", "image": "assets/images/emotions/sad.png", "options": ["Sad", "Happy", "Scared"], "answer": "Sad"},
      {"type": "image", "question": "How does this face feel?", "image": "assets/images/emotions/angry.png", "options": ["Angry", "Happy", "Tired"], "answer": "Angry"},
      {"type": "image", "question": "Guess the feeling!", "image": "assets/images/emotions/scared.png", "options": ["Scared", "Sad", "Excited"], "answer": "Scared"},
      {"type": "image", "question": "How does this face feel?", "image": "assets/images/emotions/excited.png", "options": ["Excited", "Angry", "Sleepy"], "answer": "Excited"},
      {"type": "image", "question": "Guess the feeling!", "image": "assets/images/emotions/tired.png", "options": ["Tired", "Happy", "Sad"], "answer": "Tired"},
      {"type": "image", "question": "How does this face feel?", "image": "assets/images/emotions/surprised.png", "options": ["Surprised", "Scared", "Angry"], "answer": "Surprised"},
      {"type": "image", "question": "Guess the feeling!", "image": "assets/images/emotions/sleepy.png", "options": ["Sleepy", "Excited", "Happy"], "answer": "Sleepy"},
      {"type": "image", "question": "How does this face feel?", "image": "assets/images/emotions/shy.png", "options": ["Shy", "Sad", "Tired"], "answer": "Shy"},
      {"type": "image", "question": "Guess the feeling!", "image": "assets/images/emotions/love.png", "options": ["Love", "Angry", "Scared"], "answer": "Love"},
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
                      ],
                    ),
                  ),
      ),
    );
  }
}