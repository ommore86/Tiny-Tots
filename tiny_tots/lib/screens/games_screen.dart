import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(home: GamesHomeScreen()));

// ======================
// 🏠 MAIN GAMES SCREEN
// ======================
class GamesHomeScreen extends StatelessWidget {
  final List<GameCard> games = [
    GameCard(
      title: "ABC Match", 
      icon: Icons.abc,
      color: Colors.orange,
      screen: AlphabetGameScreen(),
    ),
    GameCard(
      title: "Counting Fun", 
      icon: Icons.filter_3,
      color: Colors.green,
      screen: CountingGameScreen(),
    ),
    GameCard(
      title: "Shape Puzzles", 
      icon: Icons.crop_square,
      color: Colors.blue,
      screen: ShapeGameScreen(),
    ),
    GameCard(
      title: "Animal Sounds", 
      icon: Icons.pets,
      color: Colors.purple,
      screen: AnimalGameScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Fun Learning Games",
          style: GoogleFonts.fredoka(
            fontSize: 24,
            color: Colors.white,
          )),
        backgroundColor: Colors.blue,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: games.length,
          itemBuilder: (context, index) => _GameCardItem(game: games[index]),
        ),
      ),
    );
  }
}

// ======================
// 🎮 GAME CARD WIDGET
// ======================
class _GameCardItem extends StatelessWidget {
  final GameCard game;
  const _GameCardItem({required this.game});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => game.screen),
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [game.color, game.color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(game.icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(game.title,
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  color: Colors.white,
                )),
              SizedBox(height: 5),
              Text("Tap to play!",
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

// ======================
// 🔤 ALPHABET GAME
// ======================
class AlphabetGameScreen extends StatefulWidget {
  @override
  _AlphabetGameScreenState createState() => _AlphabetGameScreenState();
}

class _AlphabetGameScreenState extends State<AlphabetGameScreen> {
  final List<String> uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  final List<String> lowercase = 'abcdefghijklmnopqrstuvwxyz'.split('');
  late List<String> shuffledLowercase;
  String? selectedUppercase;

  @override
  void initState() {
    super.initState();
    shuffledLowercase = List.from(lowercase)..shuffle();
  }

  void _checkMatch(String upperLetter, String lowerLetter) {
    final upperIndex = uppercase.indexOf(upperLetter);
    if (lowerLetter == lowercase[upperIndex]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Good job! $upperLetter matches $lowerLetter"),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        shuffledLowercase.remove(lowerLetter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("ABC Match"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Match uppercase to lowercase:",
                style: GoogleFonts.poppins(fontSize: 20)),
            SizedBox(height: 30),
            
            // Uppercase Letters (Draggable)
            Wrap(
              spacing: 10,
              children: uppercase.map((letter) => Draggable<String>(
                data: letter,
                feedback: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(letter,
                        style: GoogleFonts.fredoka(fontSize: 24)),
                  ),
                ),
                childWhenDragging: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(letter,
                        style: GoogleFonts.fredoka(fontSize: 24)),
                  ),
                ),
              )).toList(),
            ),
            
            SizedBox(height: 40),
            Icon(Icons.arrow_downward, size: 40),
            SizedBox(height: 20),
            
            // Lowercase Letters (Targets)
            Wrap(
              spacing: 10,
              children: shuffledLowercase.map((letter) {
                return DragTarget<String>(
                  builder: (context, _, __) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Center(
                      child: Text(letter,
                          style: GoogleFonts.fredoka(fontSize: 24)),
                    ),
                  ),
                  onAccept: (data) => _checkMatch(data, letter),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
// ======================
// 🔢 COUNTING GAME
// ======================
class CountingGameScreen extends StatefulWidget {
  @override
  _CountingGameScreenState createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen> {
  int count = 0;
  final ConfettiController _confettiController = ConfettiController();

  void _incrementCount() {
    setState(() => count++);
    if (count == 5) _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("Counting Fun"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Count the apples:",
                    style: GoogleFonts.poppins(fontSize: 20)),
                SizedBox(height: 20),
                
                // Interactive Fruits
                Wrap(
                  spacing: 10,
                  children: List.generate(10, (index) => GestureDetector(
                    onTap: _incrementCount,
                    child: AnimatedScale(
                      scale: index < count ? 0.9 : 1.0,
                      duration: Duration(milliseconds: 200),
                      child: Image.asset(
                        'assets/images/fruits/apple.png',
                        width: 50,
                        color: Colors.red,
                        errorBuilder: (context, error, stackTrace) => 
                          Icon(Icons.apple, size: 50, color: Colors.red),
                      ),
                    ),
                  )),
                ),
                
                SizedBox(height: 30),
                Text("$count / 5",
                    style: GoogleFonts.fredoka(fontSize: 40)),
                if (count >= 5) ...[
                  SizedBox(height: 20),
                  Text("Great counting! 🎉",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.green[700],
                      )),
                ],
              ],
            ),
          ),
          
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),
        ],
      ),
    );
  }
}

// ======================
// 🔵 SHAPE GAME
// ======================
class ShapeGameScreen extends StatelessWidget {
  final Map<String, Color> shapes = {
    '▲': Colors.blue,
    '●': Colors.red,
    '■': Colors.yellow,
    '♥': Colors.purple,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Shape Puzzles"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("Drag shapes to match:",
              style: GoogleFonts.poppins(fontSize: 20)),
            SizedBox(height: 30),
            
            // Shape Targets
            Container(
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    left: 50,
                    child: _ShapeContainer(color: Colors.blue, shape: '▲')),
                  Positioned(
                    right: 50,
                    top: 50,
                    child: _ShapeContainer(color: Colors.red, shape: '●')),
                ],
              ),
            ),
            
            SizedBox(height: 40),
            Text("Available shapes:",
              style: GoogleFonts.poppins(fontSize: 18)),
            SizedBox(height: 20),
            
            // Draggable Shapes
            Wrap(
              spacing: 20,
              children: shapes.entries.map((e) => Draggable<String>(
                data: e.key,
                feedback: _ShapeWidget(shape: e.key, color: e.value),
                child: _ShapeWidget(shape: e.key, color: e.value),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShapeContainer extends StatelessWidget {
  final Color color;
  final String shape;
  
  const _ShapeContainer({required this.color, required this.shape});

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, _, __) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(shape,
            style: TextStyle(fontSize: 40, color: color)),
        ),
      ),
      onAccept: (data) {
        if (data == shape) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Correct! It's a ${_getShapeName(shape)}")),
          );
        }
      },
    );
  }

  String _getShapeName(String shape) {
    return {
      '▲': 'triangle',
      '●': 'circle',
      '■': 'square',
      '♥': 'heart',
    }[shape] ?? 'shape';
  }
}

class _ShapeWidget extends StatelessWidget {
  final String shape;
  final Color color;
  
  const _ShapeWidget({required this.shape, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(shape,
          style: TextStyle(fontSize: 30, color: color)),
      ),
    );
  }
}

// ======================
// 🐘 ANIMAL SOUND GAME
// ======================
class AnimalGameScreen extends StatefulWidget {
  @override
  _AnimalGameScreenState createState() => _AnimalGameScreenState();
}

class _AnimalGameScreenState extends State<AnimalGameScreen> {
  final AudioPlayer _player = AudioPlayer();
  final Map<String, String> animals = {
    'Lion': 'roar.mp3',
    'Cow': 'moo.mp3',
    'Duck': 'quack.mp3',
    'Dog': 'bark.mp3',
  };
  String? guessedAnimal;

  Future<void> _playSound(String sound) async {
    await _player.play(AssetSource('sounds/animals/$sound'));
  }

  void _checkGuess(String animal) {
    setState(() => guessedAnimal = animal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text("Animal Sounds"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Guess the animal:",
              style: GoogleFonts.poppins(fontSize: 22)),
            SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: () => _playSound(animals.values.first),
              child: Text("Play Sound",
                style: GoogleFonts.poppins(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.purple,
              ),
            ),
            
            SizedBox(height: 40),
            Wrap(
              spacing: 10,
              children: animals.keys.map((animal) => ChoiceChip(
                label: Text(animal),
                selected: guessedAnimal == animal,
                onSelected: (_) => _checkGuess(animal),
              )).toList(),
            ),
            
            if (guessedAnimal != null) ...[
              SizedBox(height: 30),
              Text(
                guessedAnimal == animals.keys.first 
                  ? "Correct! 🎉" 
                  : "Try again!",
                style: GoogleFonts.fredoka(
                  fontSize: 24,
                  color: guessedAnimal == animals.keys.first 
                    ? Colors.green 
                    : Colors.red,
                )),
            ],
          ],
        ),
      ),
    );
  }
}

// ======================
// 🃏 GAME CARD MODEL
// ======================
class GameCard {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;

  GameCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.screen,
  });
}