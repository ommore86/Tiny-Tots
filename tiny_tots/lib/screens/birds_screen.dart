import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BirdsScreen(),
  ));
}

class BirdsScreen extends StatelessWidget {
  final List<Map<String, String>> birdsList = [
    {'name': 'Sparrow', 'image': 'assets/images/birds/sparrow.png'},
    {'name': 'Parrot', 'image': 'assets/images/birds/parrot.png'},
    {'name': 'Eagle', 'image': 'assets/images/birds/eagle.png'},
    {'name': 'Peacock', 'image': 'assets/images/birds/peacock.png'},
    {'name': 'Owl', 'image': 'assets/images/birds/owl.png'},
    {'name': 'Penguin', 'image': 'assets/images/birds/penguin.png'},
    {'name': 'Pigeon', 'image': 'assets/images/birds/pigeon.png'},
    {'name': 'Crow', 'image': 'assets/images/birds/crow.png'},
    {'name': 'Swan', 'image': 'assets/images/birds/swan.png'},
    {'name': 'Duck', 'image': 'assets/images/birds/duck.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Birds"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.lightBlue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: birdsList.length,
          itemBuilder: (context, index) {
            return _buildBirdCard(context, birdsList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildBirdCard(BuildContext context, Map<String, String> birdData, int index) {
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
              builder: (context) => BirdDetailScreen(
                birdsList: birdsList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: birdData['name']!,
              child: Image.asset(birdData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              birdData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}

class BirdDetailScreen extends StatefulWidget {
  final List<Map<String, String>> birdsList;
  final int currentIndex;

  BirdDetailScreen({Key? key, required this.birdsList, required this.currentIndex}) : super(key: key);

  @override
  _BirdDetailScreenState createState() => _BirdDetailScreenState();
}

class _BirdDetailScreenState extends State<BirdDetailScreen> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speakWord(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4); // Slower for kids
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text); 
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> birdData = widget.birdsList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(birdData['name']!),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.lightBlue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: birdData['name']!,
                child: Image.asset(birdData['image']!, width: 250, height: 250),
              ),
              SizedBox(height: 20),
              Text(
                birdData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),

              // Play Sound Button (Pronounce Bird Name)
              ElevatedButton.icon(
                onPressed: () => _speakWord(birdData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Sound"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.currentIndex > 0)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirdDetailScreen(
                              birdsList: widget.birdsList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  if (widget.currentIndex < widget.birdsList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirdDetailScreen(
                              birdsList: widget.birdsList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
