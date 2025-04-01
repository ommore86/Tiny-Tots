import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ColorsScreen(),
  ));
}

class ColorsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> colorsList = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'Brown', 'color': Colors.brown},
    {'name': 'Black', 'color': Colors.black},
    {'name': 'White', 'color': Colors.white},
    {'name': 'Gray', 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Colors", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink[50],
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: colorsList.length,
        itemBuilder: (context, index) {
          return _buildColorCard(context, index);
        },
      ),
    );
  }

  Widget _buildColorCard(BuildContext context, int index) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ColorDetailScreen(
                colorsList: colorsList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorsList[index]['color'],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              colorsList[index]['name'],
              style: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class ColorDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> colorsList;
  final int currentIndex;
  final FlutterTts flutterTts = FlutterTts();

  ColorDetailScreen({Key? key, required this.colorsList, required this.currentIndex}) : super(key: key);

  void _speakColor() {
    flutterTts.speak(colorsList[currentIndex]['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${colorsList[currentIndex]['name']}", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              colorsList[currentIndex]['name'],
              style: GoogleFonts.fredoka(fontSize: 40, fontWeight: FontWeight.bold, color: colorsList[currentIndex]['color']),
            ),
            SizedBox(height: 20),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: colorsList[currentIndex]['color'],
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _speakColor,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Play Sound", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              onPressed: currentIndex > 0
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorDetailScreen(
                            colorsList: colorsList,
                            currentIndex: currentIndex - 1,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              onPressed: currentIndex < colorsList.length - 1
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorDetailScreen(
                            colorsList: colorsList,
                            currentIndex: currentIndex + 1,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
