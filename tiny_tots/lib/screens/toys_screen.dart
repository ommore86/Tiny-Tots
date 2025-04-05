import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ToysScreen extends StatelessWidget {
  final List<Map<String, String>> toysList = [
    {'name': 'Ball', 'image': 'assets/images/toys/ball.png'},
    {'name': 'Boat', 'image': 'assets/images/toys/boat.png'},
    {'name': 'Car', 'image': 'assets/images/toys/car.png'},
    {'name': 'Doll', 'image': 'assets/images/toys/doll.png'},
    {'name': 'Kite', 'image': 'assets/images/toys/kite.png'},
    {'name': 'Plane', 'image': 'assets/images/toys/plane.png'},
    {'name': 'Puzzle', 'image': 'assets/images/toys/puzzle.png'},
    {'name': 'Robot', 'image': 'assets/images/toys/robot.png'},
    {'name': 'Teddy Bear', 'image': 'assets/images/toys/teddy.png'},
    {'name': 'Train', 'image': 'assets/images/toys/train.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toys", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: toysList.length,
          itemBuilder: (context, index) {
            return _buildToyCard(context, toysList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildToyCard(BuildContext context, Map<String, String> toyData, int index) {
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
              builder: (context) => ToyDetailScreen(
                toysList: toysList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: toyData['name']!,
              child: Image.asset(toyData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              toyData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}

class ToyDetailScreen extends StatefulWidget {
  final List<Map<String, String>> toysList;
  final int currentIndex;

  ToyDetailScreen({Key? key, required this.toysList, required this.currentIndex}) : super(key: key);

  @override
  _ToyDetailScreenState createState() => _ToyDetailScreenState();
}

class _ToyDetailScreenState extends State<ToyDetailScreen> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speakSpelling(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.2);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> toyData = widget.toysList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(toyData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: toyData['name']!,
                child: Image.asset(toyData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                toyData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _speakSpelling(toyData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Spelling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.currentIndex > 0)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToyDetailScreen(
                              toysList: widget.toysList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                    ),
                  if (widget.currentIndex < widget.toysList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToyDetailScreen(
                              toysList: widget.toysList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
