import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart'; // For celebration effects

class PuzzlesScreen extends StatefulWidget {
  @override
  _PuzzlesScreenState createState() => _PuzzlesScreenState();
}

class _PuzzlesScreenState extends State<PuzzlesScreen> {
  late ConfettiController _confettiController;
  final List<PuzzleCategory> _categories = [
    PuzzleCategory(
      title: "Animals",
      icon: Icons.pets,
      puzzles: [
        PuzzleItem(image: 'assets/images/animals/bear.png', answer: 'bear'),
        PuzzleItem(image: 'assets/images/animals/cat.png', answer: 'cat'),
        PuzzleItem(image: 'assets/images/animals/dog.png', answer: 'dog'),
        PuzzleItem(image: 'assets/images/animals/elephant.png', answer: 'Elephant'),
        PuzzleItem(image: 'assets/images/animals/giraffe.png', answer: 'Giraffe'),
        PuzzleItem(image: 'assets/images/animals/lion.png', answer: 'Lion'),
        PuzzleItem(image: 'assets/images/animals/monkey.png', answer: 'monkey'),
        PuzzleItem(image: 'assets/images/animals/rabbit.png', answer: 'Rabbit'),
        PuzzleItem(image: 'assets/images/animals/tiger.png', answer: 'Tiger'),
        PuzzleItem(image: 'assets/images/animals/zebra.png', answer: 'Zebra'),
      ],
      color: Colors.orange,
    ),

    PuzzleCategory(
      title: "Birds",
      icon: Icons.flight,
      puzzles: [
        PuzzleItem(image: 'assets/images/birds/crow.png', answer: 'Crow'),
        PuzzleItem(image: 'assets/images/birds/duck.png', answer: 'Duck'),
        PuzzleItem(image: 'assets/images/birds/eagle.png', answer: 'Eagle'),
        PuzzleItem(image: 'assets/images/birds/owl.png', answer: 'Owl'),
        PuzzleItem(image: 'assets/images/birds/parrot.png', answer: 'Parrot'),
        PuzzleItem(image: 'assets/images/birds/peacock.png', answer: 'Peacock'),
        PuzzleItem(image: 'assets/images/birds/penguin.png', answer: 'Penguin'),
        PuzzleItem(image: 'assets/images/birds/pegion.png', answer: 'Pegion'),
        PuzzleItem(image: 'assets/images/birds/sparrow.png', answer: 'Sparrow'),
        PuzzleItem(image: 'assets/images/birds/swan.png', answer: 'Swan'),
      ],
      color: Colors.green,
    ),

    PuzzleCategory(
      title: "Colors",
      icon: Icons.color_lens,
      puzzles: [
        PuzzleItem(image: 'assets/images/colors/black.png', answer: 'Black'),
        PuzzleItem(image: 'assets/images/colors/blue.png', answer: 'Blue'),
        PuzzleItem(image: 'assets/images/colors/brown.png', answer: 'Brown'),
        PuzzleItem(image: 'assets/images/colors/green.png', answer: 'Green'),
        PuzzleItem(image: 'assets/images/colors/orange.png', answer: 'Orange'),
        PuzzleItem(image: 'assets/images/colors/pink.png', answer: 'Pink'),
        PuzzleItem(image: 'assets/images/colors/purple.png', answer: 'Purple'),
        PuzzleItem(image: 'assets/images/colors/red.png', answer: 'Red'),
        PuzzleItem(image: 'assets/images/colors/white.png', answer: 'White'),
        PuzzleItem(image: 'assets/images/colors/yellow.png', answer: 'Yellow'),
      ],
      color: Colors.purple,
    ),

    PuzzleCategory(
      title: "Shapes",
      icon: Icons.shape_line,
      puzzles: [
        PuzzleItem(image: 'assets/images/shapes/circle.png', answer: 'Circle'),
        PuzzleItem(image: 'assets/images/shapes/diamond.png', answer: 'Diamond'),
        PuzzleItem(image: 'assets/images/shapes/hexagon.png', answer: 'Hexagon'),
        PuzzleItem(image: 'assets/images/shapes/oval.png', answer: 'Oval'),
        PuzzleItem(image: 'assets/images/shapes/pentagon.png', answer: 'Pentagon'),
        PuzzleItem(image: 'assets/images/shapes/rectangle.png', answer: 'Rectangle'),
        PuzzleItem(image: 'assets/images/shapes/square.png', answer: 'Square'),
        PuzzleItem(image: 'assets/images/shapes/star.png', answer: 'Star'),
        PuzzleItem(image: 'assets/images/shapes/triangle.png', answer: 'Triangle'),
      ],
      color: Colors.blue,
    ),

    PuzzleCategory(
      title: "Fruits",
      icon: Icons.apple,
      puzzles: [
        PuzzleItem(image: 'assets/images/fruits/apple.png', answer: 'Apple'),
        PuzzleItem(image: 'assets/images/fruits/banana.png', answer: 'Banana'),
        PuzzleItem(image: 'assets/images/fruits/cherry.png', answer: 'cherry'),
        PuzzleItem(image: 'assets/images/fruits/grape.png', answer: 'grape'),
        PuzzleItem(image: 'assets/images/fruits/kiwi.png', answer: 'kiwi'),
        PuzzleItem(image: 'assets/images/fruits/mango.png', answer: 'mango'),
        PuzzleItem(image: 'assets/images/fruits/orange.png', answer: 'orange'),
        PuzzleItem(image: 'assets/images/fruits/pear.png', answer: 'pear'),
        PuzzleItem(image: 'assets/images/fruits/pineapple.png', answer: 'pineapple'),
        PuzzleItem(image: 'assets/images/fruits/strawberry.png', answer: 'strawberry'),
      ],
      color: Colors.green,
    ),

    PuzzleCategory(
      title: "Numbers",
      icon: Icons.numbers,
      puzzles: [
        PuzzleItem(image: 'assets/numbers/1.png', answer: 'One'),
        PuzzleItem(image: 'assets/numbers/2.png', answer: 'Two'),
        PuzzleItem(image: 'assets/numbers/3.png', answer: 'Three'),
        PuzzleItem(image: 'assets/numbers/4.png', answer: 'Four'),
        PuzzleItem(image: 'assets/numbers/5.png', answer: 'Five'),
        PuzzleItem(image: 'assets/numbers/6.png', answer: 'Six'),
        PuzzleItem(image: 'assets/numbers/7.png', answer: 'Seven'),
        PuzzleItem(image: 'assets/numbers/8.png', answer: 'Eight'),
        PuzzleItem(image: 'assets/numbers/9.png', answer: 'Nine'),
        PuzzleItem(image: 'assets/numbers/10.png', answer: 'Ten'),
      ],
      color: Colors.yellow,
    ),

    PuzzleCategory(
      title: "Food",
      icon: Icons.fastfood,
      puzzles: [
        PuzzleItem(image: 'assets/images/foods/bread.png', answer: 'Bread'),
        PuzzleItem(image: 'assets/images/foods/burger.png', answer: 'Burger'),
        PuzzleItem(image: 'assets/images/foods/cake.png', answer: 'Cake'),
        PuzzleItem(image: 'assets/images/foods/cookie.png', answer: 'Cookie'),
        PuzzleItem(image: 'assets/images/foods/donut.png', answer: 'Donut'),
        PuzzleItem(image: 'assets/images/foods/icecream.png', answer: 'Ice Cream'),
        PuzzleItem(image: 'assets/images/foods/pasta.png', answer: 'Pasta'),
        PuzzleItem(image: 'assets/images/foods/pizza.png', answer: 'Pizza'),
        PuzzleItem(image: 'assets/images/foods/sandwich.png', answer: 'Sandwich'),
        PuzzleItem(image: 'assets/images/foods/soup.png', answer: 'Soup'),
      ],
      color: Colors.brown,
    ),

    PuzzleCategory(
      title: "Vehicles",
      icon: Icons.directions_car,
      puzzles: [
        PuzzleItem(image: 'assets/images/vehicles/bicycle.png', answer: 'Bicycle'),
        PuzzleItem(image: 'assets/images/vehicles/boat.png', answer: 'Boat'),
        PuzzleItem(image: 'assets/images/vehicles/bus.png', answer: 'Bus'),
        PuzzleItem(image: 'assets/images/vehicles/car.png', answer: 'Car'),
        PuzzleItem(image: 'assets/images/vehicles/helicopter.png', answer: 'Helicopter'),
        PuzzleItem(image: 'assets/images/vehicles/plane.png', answer: 'Plane'),
        PuzzleItem(image: 'assets/images/vehicles/scooter.png', answer: 'Scooter'),
        PuzzleItem(image: 'assets/images/vehicles/ship.png', answer: 'ship'),
        PuzzleItem(image: 'assets/images/vehicles/train.png', answer: 'Train'),
        PuzzleItem(image: 'assets/images/vehicles/truck.png', answer: 'Truck'),
      ],
      color: Colors.red,
    ),

    PuzzleCategory(
      title: "Toys",
      icon: Icons.toys,
      puzzles: [
        PuzzleItem(image: 'assets/images/toys/ball.png', answer: 'Ball'),
        PuzzleItem(image: 'assets/images/toys/boat.png', answer: 'Boat'),
        PuzzleItem(image: 'assets/images/toys/car.png', answer: 'Car'),
        PuzzleItem(image: 'assets/images/toys/doll.png', answer: 'Doll'),
        PuzzleItem(image: 'assets/images/toys/kite.png', answer: 'Kite'),
        PuzzleItem(image: 'assets/images/toys/plane.png', answer: 'Plane'),
        PuzzleItem(image: 'assets/images/toys/puzzle.png', answer: 'Puzzle'),
        PuzzleItem(image: 'assets/images/toys/robot.png', answer: 'Robot'),
        PuzzleItem(image: 'assets/images/toys/teddy.png', answer: 'Teddy Bear'),
        PuzzleItem(image: 'assets/images/toys/train.png', answer: 'Train'),
      ],
      color: Colors.teal,
    ),

    PuzzleCategory(
      title: "Emotions",
      icon: Icons.emoji_emotions,
      puzzles: [
        PuzzleItem(image: 'assets/images/emotions/happy.png', answer: 'Happy'),
        PuzzleItem(image: 'assets/images/emotions/sad.png', answer: 'Sad'),
        PuzzleItem(image: 'assets/images/emotions/angry.png', answer: 'Angry'),
        PuzzleItem(image: 'assets/images/emotions/surprised.png', answer: 'Surprised'),
        PuzzleItem(image: 'assets/images/emotions/love.png', answer: 'Love'),
        PuzzleItem(image: 'assets/images/emotions/excited.png', answer: 'Excited'),
        PuzzleItem(image: 'assets/images/emotions/scared.png', answer: 'Scared'),
        PuzzleItem(image: 'assets/images/emotions/tired.png', answer: 'Tired'),
        PuzzleItem(image: 'assets/images/emotions/sleepy.png', answer: 'Sleepy'),
        PuzzleItem(image: 'assets/images/emotions/shy.png', answer: 'Shy'),
      ],
      color: Colors.cyan,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text("Fun Puzzles", 
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Choose a category to play!",
              style: GoogleFonts.fredoka(
                fontSize: 20,
                color: Colors.purple[800],
              )),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(_categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(PuzzleCategory category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PuzzleGameScreen(
              category: category,
              confettiController: _confettiController,
            ),
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [category.color, category.color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(category.title,
                style: GoogleFonts.fredoka(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
              SizedBox(height: 5),
              Text("${category.puzzles.length} puzzles",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                )),
            ],
          ),
        ),
      ),
    );
  }
}

class PuzzleGameScreen extends StatefulWidget {
  final PuzzleCategory category;
  final ConfettiController confettiController;

  const PuzzleGameScreen({
    required this.category,
    required this.confettiController,
  });

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  int _currentPuzzleIndex = 0;
  List<String> _shuffledLetters = [];
  List<String> _selectedLetters = [];
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _shuffleLetters();
  }

  void _shuffleLetters() {
    setState(() {
      _isCorrect = false;
      final puzzle = widget.category.puzzles[_currentPuzzleIndex];
      _shuffledLetters = puzzle.answer.split('')..shuffle();
      _selectedLetters = [];
    });
  }

  void _onLetterSelected(String letter) {
    setState(() {
      _selectedLetters.add(letter);
      _shuffledLetters.remove(letter);
      
      final puzzle = widget.category.puzzles[_currentPuzzleIndex];
      if (_selectedLetters.join() == puzzle.answer) {
        _isCorrect = true;
        widget.confettiController.play();
        Future.delayed(Duration(seconds: 2), () {
          if (_currentPuzzleIndex < widget.category.puzzles.length - 1) {
            setState(() {
              _currentPuzzleIndex++;
              _shuffleLetters();
            });
          } else {
            Navigator.pop(context);
          }
        });
      }
    });
  }

  void _onLetterRemoved(String letter) {
    setState(() {
      _selectedLetters.remove(letter);
      _shuffledLetters.add(letter);
      _shuffledLetters.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = widget.category.puzzles[_currentPuzzleIndex];
    
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text(widget.category.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          )),
        backgroundColor: widget.category.color,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Puzzle Image
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      puzzle.image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(Icons.image, size: 60),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Selected Letters
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _selectedLetters.map((letter) {
                        return _LetterTile(
                          letter: letter,
                          color: widget.category.color,
                          onTap: _onLetterRemoved,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Shuffled Letters
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: _shuffledLetters.map((letter) {
                    return _LetterTile(
                      letter: letter,
                      color: widget.category.color,
                      onTap: _onLetterSelected,
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                
                // Progress
                Text(
                  "Puzzle ${_currentPuzzleIndex + 1}/${widget.category.puzzles.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          
          // Confetti Effect
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: widget.confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
          
          // Success Message
          if (_isCorrect)
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, 
                      color: Colors.green, 
                      size: 60),
                    SizedBox(height: 10),
                    Text("Good Job!", 
                      style: GoogleFonts.fredoka(
                        fontSize: 30,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      )),
                    Text("It's a ${puzzle.answer}!",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      )),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LetterTile extends StatelessWidget {
  final String letter;
  final Color color;
  final Function(String) onTap;

  const _LetterTile({
    required this.letter,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(letter),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: GoogleFonts.fredoka(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class PuzzleCategory {
  final String title;
  final IconData icon;
  final List<PuzzleItem> puzzles;
  final Color color;

  PuzzleCategory({
    required this.title,
    required this.icon,
    required this.puzzles,
    required this.color,
  });
}

class PuzzleItem {
  final String image;
  final String answer;

  PuzzleItem({
    required this.image,
    required this.answer,
  });
}