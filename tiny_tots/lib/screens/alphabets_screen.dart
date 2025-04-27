import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: AlphabetsScreen()),
  );
}

class AlphabetsScreen extends StatelessWidget {
  final List<String> alphabets = 'abcdefghijklmnopqrstuvwxyz'.split('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Learn Alphabets",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: alphabets.length,
          itemBuilder: (context, index) {
            return _buildAlphabetCard(context, alphabets[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildAlphabetCard(BuildContext context, String letter, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AlphabetDetailScreen(letter: letter, index: index),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              letter.toUpperCase(),
              style: GoogleFonts.fredoka(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlphabetDetailScreen extends StatefulWidget {
  final String letter;
  final int index;

  const AlphabetDetailScreen({
    Key? key,
    required this.letter,
    required this.index,
  }) : super(key: key);

  @override
  State<AlphabetDetailScreen> createState() => _AlphabetDetailScreenState();
}

class _AlphabetDetailScreenState extends State<AlphabetDetailScreen> {
  late FlutterTts _flutterTts;
  bool _isSpeaking = false;

  final List<String> alphabets = 'abcdefghijklmnopqrstuvwxyz'.split('');

  final Map<String, String> phoneticSounds = {
    'a': 'ah ah apple. A for apple',
    'b': 'bah bah ball. B for ball',
    'c': 'kuh kuh cat. C for cat',
    'd': 'duh duh dog. D for dog',
    'e': 'e e elephant. E for elephant',
    'f': 'fa fa fish. F for fish',
    'g': 'gah gah goat. G for goat',
    'h': 'ha ha horse. H for horse',
    'i': 'i i ice cream. I for ice cream',
    'j': 'juh juh joker. J for joker',
    'k': 'kuh kuh kite. K for kite',
    'l': 'la la lion. L for lion',
    'm': 'ma ma monkey. M for monkey',
    'n': 'nuh nuh nest. N for nest',
    'o': 'awh awh orange. O for orange',
    'p': 'puh puh panda. P for panda',
    'q': 'kwuh kwuh queen. Q for queen',
    'r': 'ruh ruh rabbit. R for rabbit',
    's': 'sah sah sun. S for sun',
    't': 'tuh tuh tiger. T for tiger',
    'u': 'uhh uhh umbrella. U for umbrella',
    'v': 'vuh vuh violin. V for violin',
    'w': 'wuh wuh watch. W for watch',
    'x': 'xah xah xylophone. X for xylophone',
    'y': 'yuh yuh yacht. Y for yacht',
    'z': 'zah zah zebra. Z for zebra',
  };

  final Map<String, String> alphabetExamples = {
    'a': 'Apple',
    'b': 'Ball',
    'c': 'Cat',
    'd': 'Dog',
    'e': 'Elephant',
    'f': 'Fish',
    'g': 'Goat',
    'h': 'Horse',
    'i': 'Ice Cream',
    'j': 'Joker',
    'k': 'Kite',
    'l': 'Lion',
    'm': 'Monkey',
    'n': 'Nest',
    'o': 'Orange',
    'p': 'Panda',
    'q': 'Queen',
    'r': 'Rabbit',
    's': 'Sun',
    't': 'Tiger',
    'u': 'Umbrella',
    'v': 'Violin',
    'w': 'Watch',
    'x': 'Xylophone',
    'y': 'Yacht',
    'z': 'Zebra',
  };

  final Map<String, String> alphabetImages = {
    for (var letter in 'abcdefghijklmnopqrstuvwxyz'.split(''))
      letter: 'assets/images/Letter_${letter}.png',
  };

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _initTts() async {
    _flutterTts = FlutterTts();

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.2); // Slower for kids
    await _flutterTts.setPitch(1.0); // Higher pitch
    await _flutterTts.setVolume(1.0);

    _flutterTts.setStartHandler(() {
      setState(() => _isSpeaking = true);
    });

    _flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });

    _flutterTts.setErrorHandler((msg) {
      setState(() => _isSpeaking = false);
    });
  }

  Future<void> _speak(String letter) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }
    String sound = phoneticSounds[letter.toLowerCase()] ?? letter;
    await _flutterTts.speak(sound);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(
          "Letter ${widget.letter.toUpperCase()}",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Letter Display
          Text(
            widget.letter.toUpperCase(),
            style: GoogleFonts.fredoka(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          SizedBox(height: 20),

          // Letter Image
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              alphabetImages[widget.letter]!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 60),
            ),
          ),
          SizedBox(height: 20),

          // Example Text
          Text(
            '${alphabetExamples[widget.letter]} is for ${widget.letter.toUpperCase()}',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Play Sound Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              backgroundColor:
                  _isSpeaking ? Colors.pink[300] : Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => _speak(widget.letter),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isSpeaking ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  _isSpeaking ? "Speaking..." : "Play Sound",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.index > 0)
                FloatingActionButton(
                  heroTag: "prev_${widget.letter}",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AlphabetDetailScreen(
                              letter: alphabets[widget.index - 1],
                              index: widget.index - 1,
                            ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),

              if (widget.index < alphabets.length - 1)
                FloatingActionButton(
                  heroTag: "next_${widget.letter}",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AlphabetDetailScreen(
                              letter: alphabets[widget.index + 1],
                              index: widget.index + 1,
                            ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
