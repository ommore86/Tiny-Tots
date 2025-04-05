import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EmotionsScreen(),
  ));
}

class EmotionsScreen extends StatelessWidget {
  final List<Map<String, String>> emotionsList = [
    {'name': 'Angry', 'image': 'assets/images/emotions/angry.png'},
    {'name': 'Excited', 'image': 'assets/images/emotions/excited.png'},
    {'name': 'Happy', 'image': 'assets/images/emotions/happy.png'},
    {'name': 'Love', 'image': 'assets/images/emotions/love.png'},
    {'name': 'Sad', 'image': 'assets/images/emotions/sad.png'},
    {'name': 'Scared', 'image': 'assets/images/emotions/scared.png'},
    {'name': 'Shy', 'image': 'assets/images/emotions/shy.png'},
    {'name': 'Sleepy', 'image': 'assets/images/emotions/sleepy.png'},
    {'name': 'Surprised', 'image': 'assets/images/emotions/surprised.png'},
    {'name': 'Tired', 'image': 'assets/images/emotions/tired.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emotions", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade300],
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
          itemCount: emotionsList.length,
          itemBuilder: (context, index) {
            return _buildEmotionCard(context, emotionsList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildEmotionCard(BuildContext context, Map<String, String> emotionData, int index) {
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
              builder: (context) => EmotionDetailScreen(
                emotionsList: emotionsList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: emotionData['name']!,
              child: Image.asset(emotionData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              emotionData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink[900]),
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionDetailScreen extends StatefulWidget {
  final List<Map<String, String>> emotionsList;
  final int currentIndex;

  EmotionDetailScreen({Key? key, required this.emotionsList, required this.currentIndex}) : super(key: key);

  @override
  _EmotionDetailScreenState createState() => _EmotionDetailScreenState();
}

class _EmotionDetailScreenState extends State<EmotionDetailScreen> {
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
    Map<String, String> emotionData = widget.emotionsList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(emotionData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.pink.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: emotionData['name']!,
                child: Image.asset(emotionData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                emotionData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink[900]),
              ),
              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () => _speakSpelling(emotionData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Spelling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
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
                            builder: (context) => EmotionDetailScreen(
                              emotionsList: widget.emotionsList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                    ),
                  if (widget.currentIndex < widget.emotionsList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmotionDetailScreen(
                              emotionsList: widget.emotionsList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
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
