import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NumbersScreen(),
  ));
}

class NumbersScreen extends StatelessWidget {
  final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Numbers", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
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
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return _buildNumberCard(context, numbers[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, String number, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberDetailScreen(number: number, index: index),
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
              number,
              style: GoogleFonts.fredoka(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberDetailScreen extends StatefulWidget {
  final String number;
  final int index;

  NumberDetailScreen({Key? key, required this.number, required this.index}) : super(key: key);

  @override
  _NumberDetailScreenState createState() => _NumberDetailScreenState();
}

class _NumberDetailScreenState extends State<NumberDetailScreen> {
  late FlutterTts _flutterTts;
  final FlutterTts flutterTts = FlutterTts();
  final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  final Map<String, String> numberExamples = {
    '1': 'One Apple', '2': 'Two Balls', '3': 'Three Cats', '4': 'Four Dogs',
    '5': 'Five Elephants', '6': 'Six Fishes', '7': 'Seven Hats', '8': 'Eight Kites',
    '9': 'Nine Lions', '10': 'Ten Monkeys'
  };

  final Map<String, String> numberImages = {
    '1': 'assets/numbers/1.png', '2': 'assets/numbers/2.png', '3': 'assets/numbers/3.png',
    '4': 'assets/numbers/4.png', '5': 'assets/numbers/5.png', '6': 'assets/numbers/6.png',
    '7': 'assets/numbers/7.png', '8': 'assets/numbers/8.png', '9': 'assets/numbers/9.png',
    '10': 'assets/numbers/10.png'
  };

  void _speakNumber() async {
    await flutterTts.speak(widget.number);
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.4); // Slower for kids
    await _flutterTts.setPitch(1.2); // Higher pitch
    await _flutterTts.setVolume(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Number ${widget.number}", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.number,
            style: GoogleFonts.fredoka(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Image.asset(
              numberImages[widget.number]!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),

          Text(
            '${numberExamples[widget.number]}',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 20),

          FloatingActionButton(
            onPressed: _speakNumber,
            backgroundColor: Colors.pinkAccent,
            child: Icon(Icons.volume_up, color: Colors.white),
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.index > 0)
                FloatingActionButton(
                  heroTag: "prev",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NumberDetailScreen(
                          number: numbers[widget.index - 1],
                          index: widget.index - 1,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),

              if (widget.index < numbers.length - 1)
                FloatingActionButton(
                  heroTag: "next",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NumberDetailScreen(
                          number: numbers[widget.index + 1],
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