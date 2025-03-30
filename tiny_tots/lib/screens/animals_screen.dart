import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimalsScreen(),
  ));
}

class AnimalsScreen extends StatelessWidget {
  final List<Map<String, String>> animalsList = [
    {'name': 'Lion', 'image': 'assets/images/animals/lion.png'},
    {'name': 'Elephant', 'image': 'assets/images/animals/elephant.png'},
    {'name': 'Dog', 'image': 'assets/images/animals/dog.png'},
    {'name': 'Cat', 'image': 'assets/images/animals/cat.png'},
    {'name': 'Tiger', 'image': 'assets/images/animals/tiger.png'},
    {'name': 'Monkey', 'image': 'assets/images/animals/monkey.png'},
    {'name': 'Zebra', 'image': 'assets/images/animals/zebra.png'},
    {'name': 'Bear', 'image': 'assets/images/animals/bear.png'},
    {'name': 'Giraffe', 'image': 'assets/images/animals/giraffe.png'},
    {'name': 'Rabbit', 'image': 'assets/images/animals/rabbit.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animals", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade300],
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
          itemCount: animalsList.length,
          itemBuilder: (context, index) {
            return _buildAnimalCard(context, animalsList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildAnimalCard(BuildContext context, Map<String, String> animalData, int index) {
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
              builder: (context) => AnimalDetailScreen(
                animalsList: animalsList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: animalData['name']!,
              child: Image.asset(animalData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              animalData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalDetailScreen extends StatelessWidget {
  final List<Map<String, String>> animalsList;
  final int currentIndex;

  AnimalDetailScreen({Key? key, required this.animalsList, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> animalData = animalsList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(animalData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: animalData['name']!,
                child: Image.asset(animalData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                animalData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (currentIndex > 0)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimalDetailScreen(
                              animalsList: animalsList,
                              currentIndex: currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  if (currentIndex < animalsList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimalDetailScreen(
                              animalsList: animalsList,
                              currentIndex: currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
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
