import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AlphabetsScreen(),
  ));
}

class AlphabetsScreen extends StatelessWidget {
  final List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alphabets")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: alphabets.length,
        itemBuilder: (context, index) {
          return _buildAlphabetCard(context, alphabets[index]);
        },
      ),
    );
  }

  Widget _buildAlphabetCard(BuildContext context, String letter) {
    return Card(
      elevation: 5,
      color: Colors.pink[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlphabetDetailScreen(letter: letter),
            ),
          );
        },
        child: Center(
          child: Text(
            letter,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AlphabetDetailScreen extends StatelessWidget {
  final String letter;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AlphabetDetailScreen({Key? key, required this.letter}) : super(key: key);

  final Map<String, String> alphabetExamples = {
    'A': 'Apple', 'B': 'Ball', 'C': 'Cat', 'D': 'Dog', 'E': 'Elephant',
    'F': 'Fish', 'G': 'Guitar', 'H': 'Hat', 'I': 'Ice Cream', 'J': 'Jaguar',
    'K': 'Kite', 'L': 'Lion', 'M': 'Monkey', 'N': 'Nest', 'O': 'Orange',
    'P': 'Panda', 'Q': 'Queen', 'R': 'Rabbit', 'S': 'Sun', 'T': 'Tiger',
    'U': 'Umbrella', 'V': 'Violin', 'W': 'Whale', 'X': 'Xylophone',
    'Y': 'Yarn', 'Z': 'Zebra',
  };

  final Map<String, String> alphabetImages = {
    'A': 'assets/images/Letter_A.png',
    'B': 'assets/images/Letter_B.png',
    'C': 'assets/images/Letter_C.png',
    'D': 'assets/images/Letter_D.png',
    'E': 'assets/images/Letter_E.png',
    'F': 'assets/images/Letter_F.png',
    'G': 'assets/images/Letter_G.png',
    'H': 'assets/images/Letter_H.png',
    'I': 'assets/images/Letter_I.png',
    'J': 'assets/images/Letter_J.png',
    'K': 'assets/images/Letter_K.png',
    'L': 'assets/images/Letter_L.png',
    'M': 'assets/images/Letter_M.png',
    'N': 'assets/images/Letter_N.png',
    'O': 'assets/images/Letter_O.png',
    'P': 'assets/images/Letter_P.png',
    'Q': 'assets/images/Letter_Q.png',
    'R': 'assets/images/Letter_R.png',
    'S': 'assets/images/Letter_S.png',
    'T': 'assets/images/Letter_T.png',
    'U': 'assets/images/Letter_U.png',
    'V': 'assets/images/Letter_V.png',
    'W': 'assets/images/Letter_W.png',
    'X': 'assets/images/Letter_X.png',
    'Y': 'assets/images/Letter_Y.png',
    'Z': 'assets/images/Letter_Z.png',
  };

  final Map<String, String> alphabetSounds = {
    'A': 'assets/sounds/a.mp3',
    'B': 'assets/sounds/b.mp3',
    'C': 'assets/sounds/c.mp3',
    'D': 'assets/sounds/d.mp3',
    'E': 'assets/sounds/e.mp3',
    'F': 'assets/sounds/f.mp3',
    'G': 'assets/sounds/g.mp3',
    'H': 'assets/sounds/h.mp3',
    'I': 'assets/sounds/i.mp3',
    'J': 'assets/sounds/j.mp3',
    'K': 'assets/sounds/k.mp3',
    'L': 'assets/sounds/l.mp3',
    'M': 'assets/sounds/m.mp3',
    'N': 'assets/sounds/n.mp3',
    'O': 'assets/sounds/o.mp3',
    'P': 'assets/sounds/p.mp3',
    'Q': 'assets/sounds/q.mp3',
    'R': 'assets/sounds/r.mp3',
    'S': 'assets/sounds/s.mp3',
    'T': 'assets/sounds/t.mp3',
    'U': 'assets/sounds/u.mp3',
    'V': 'assets/sounds/v.mp3',
    'W': 'assets/sounds/w.mp3',
    'X': 'assets/sounds/x.mp3',
    'Y': 'assets/sounds/y.mp3',
    'Z': 'assets/sounds/z.mp3',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details for $letter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            SizedBox(height: 20),

            Image.asset(
              alphabetImages[letter]!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),

            Text(
              '${alphabetExamples[letter]} is for $letter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _playSound(letter),
              child: Text("Play Sound"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playSound(String letter) async {
  final player = AudioPlayer();
  String? soundPath = alphabetSounds[letter];

  if (soundPath != null) {
    try {
      await player.play(AssetSource(soundPath)); // ✅ Correct way to play
    } catch (e) {
      print("Error playing sound: $e"); // Debugging error
    }
  }
}
}