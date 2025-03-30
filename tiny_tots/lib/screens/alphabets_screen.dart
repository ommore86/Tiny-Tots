import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AlphabetsScreen(),
  ));
}

class AlphabetsScreen extends StatelessWidget {
  final List<String> alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Alphabets", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
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
            builder: (context) => AlphabetDetailScreen(letter: letter, index: index),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              letter,
              style: GoogleFonts.fredoka(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class AlphabetDetailScreen extends StatelessWidget {
  final String letter;
  final int index;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AlphabetDetailScreen({Key? key, required this.letter, required this.index}) : super(key: key);

  final List<String> alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  final Map<String, String> alphabetExamples = {
    'A': 'Apple', 'B': 'Ball', 'C': 'Cat', 'D': 'Dog', 'E': 'Elephant',
    'F': 'Fish', 'G': 'Guitar', 'H': 'Hat', 'I': 'Ice Cream', 'J': 'Jaguar',
    'K': 'Kite', 'L': 'Lion', 'M': 'Monkey', 'N': 'Nest', 'O': 'Orange',
    'P': 'Panda', 'Q': 'Queen', 'R': 'Rabbit', 'S': 'Sun', 'T': 'Tiger',
    'U': 'Umbrella', 'V': 'Violin', 'W': 'Whale', 'X': 'Xylophone',
    'Y': 'Yarn', 'Z': 'Zebra',
  };

  final Map<String, String> alphabetImages = {
    for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''))
      letter: 'assets/images/Letter_$letter.png'
  };

  final Map<String, String> alphabetSounds = {
    for (var letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''))
      letter: 'assets/sounds/$letter.mp3'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Letter $letter", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Letter Display
          Text(
            letter,
            style: GoogleFonts.fredoka(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          SizedBox(height: 20),

          // Letter Image
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Image.asset(
              alphabetImages[letter]!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),

          // Example Text
          Text(
            '${alphabetExamples[letter]} is for $letter',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 20),

          // Play Sound Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () => _playSound(letter),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.volume_up, color: Colors.white),
                SizedBox(width: 8),
                Text("Play Sound", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (index > 0)
                FloatingActionButton(
                  heroTag: "prev",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlphabetDetailScreen(
                          letter: alphabets[index - 1],
                          index: index - 1,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),

              if (index < alphabets.length - 1)
                FloatingActionButton(
                  heroTag: "next",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlphabetDetailScreen(
                          letter: alphabets[index + 1],
                          index: index + 1,
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

  Future<void> _playSound(String letter) async {
    await _audioPlayer.play(AssetSource(alphabetSounds[letter]!));
  }
}