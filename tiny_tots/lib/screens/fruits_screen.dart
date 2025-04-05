import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FruitsScreen extends StatelessWidget {
  final List<Map<String, String>> fruitsList = [
    {'name': 'Apple', 'image': 'assets/images/fruits/apple.png'},
    {'name': 'Banana', 'image': 'assets/images/fruits/banana.png'},
    {'name': 'Cherry', 'image': 'assets/images/fruits/cherry.png'},
    {'name': 'Grapes', 'image': 'assets/images/fruits/grape.png'},
    {'name': 'Kiwi', 'image': 'assets/images/fruits/kiwi.png'},
    {'name': 'Mango', 'image': 'assets/images/fruits/mango.png'},
    {'name': 'Orange', 'image': 'assets/images/fruits/orange.png'},
    {'name': 'Pear', 'image': 'assets/images/fruits/pear.png'},
    {'name': 'Pineapple', 'image': 'assets/images/fruits/pineapple.png'},
    {'name': 'Strawberry', 'image': 'assets/images/fruits/strawberry.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade100, Colors.red.shade300],
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
          itemCount: fruitsList.length,
          itemBuilder: (context, index) {
            return _buildFruitCard(context, fruitsList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildFruitCard(BuildContext context, Map<String, String> fruitData, int index) {
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
              builder: (context) => FruitDetailScreen(
                fruitsList: fruitsList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: fruitData['name']!,
              child: Image.asset(fruitData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              fruitData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }
}

class FruitDetailScreen extends StatefulWidget {
  final List<Map<String, String>> fruitsList;
  final int currentIndex;

  FruitDetailScreen({Key? key, required this.fruitsList, required this.currentIndex}) : super(key: key);

  @override
  _FruitDetailScreenState createState() => _FruitDetailScreenState();
}

class _FruitDetailScreenState extends State<FruitDetailScreen> {
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
    Map<String, String> fruitData = widget.fruitsList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(fruitData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.red.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: fruitData['name']!,
                child: Image.asset(fruitData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                fruitData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _speakSpelling(fruitData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Spelling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
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
                            builder: (context) => FruitDetailScreen(
                              fruitsList: widget.fruitsList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  if (widget.currentIndex < widget.fruitsList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FruitDetailScreen(
                              fruitsList: widget.fruitsList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
