import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FoodScreen extends StatelessWidget {
  final List<Map<String, String>> foodList = [
    {'name': 'Bread', 'image': 'assets/images/foods/bread.png'},
    {'name': 'Burger', 'image': 'assets/images/foods/burger.png'},
    {'name': 'Cake', 'image': 'assets/images/foods/cake.png'},
    {'name': 'Cookie', 'image': 'assets/images/foods/cookie.png'},
    {'name': 'Donut', 'image': 'assets/images/foods/donut.png'},
    {'name': 'Ice Cream', 'image': 'assets/images/foods/icecream.png'},
    {'name': 'Pasta', 'image': 'assets/images/foods/pasta.png'},
    {'name': 'Pizza', 'image': 'assets/images/foods/pizza.png'},
    {'name': 'Sandwich', 'image': 'assets/images/foods/sandwich.png'},
    {'name': 'Soup', 'image': 'assets/images/foods/soup.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade300],
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
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            return _buildFoodCard(context, foodList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, Map<String, String> foodData, int index) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailScreen(
                foodList: foodList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: foodData['name']!,
              child: Image.asset(foodData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              foodData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodDetailScreen extends StatefulWidget {
  final List<Map<String, String>> foodList;
  final int currentIndex;

  FoodDetailScreen({Key? key, required this.foodList, required this.currentIndex}) : super(key: key);

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
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
    Map<String, String> foodData = widget.foodList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(foodData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.green.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: foodData['name']!,
                child: Image.asset(foodData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                foodData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _speakSpelling(foodData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Spelling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
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
                            builder: (context) => FoodDetailScreen(
                              foodList: widget.foodList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                  if (widget.currentIndex < widget.foodList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailScreen(
                              foodList: widget.foodList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
