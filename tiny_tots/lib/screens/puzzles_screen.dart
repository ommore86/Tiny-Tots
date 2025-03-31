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
        PuzzleItem(image: 'assets/images/animals/Tiger.png', answer: 'Tiger'),
        PuzzleItem(image: 'assets/images/animals/Zebra.png', answer: 'Zebra'),
      ],
      color: Colors.orange,
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