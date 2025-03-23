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
      appBar: AppBar(title: Text("Animals")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: animalsList.length,
        itemBuilder: (context, index) {
          return _buildAnimalCard(context, animalsList[index], index);
        },
      ),
    );
  }

  Widget _buildAnimalCard(BuildContext context, Map<String, String> animalData, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
            Image.asset(animalData['image']!, width: 100, height: 100),
            SizedBox(height: 10),
            Text(
              animalData['name']!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      appBar: AppBar(title: Text("Details for ${animalData['name']}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(animalData['image']!, width: 200, height: 200),
            SizedBox(height: 20),
            Text(
              animalData['name']!,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // Buttons for navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
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
                    child: Text("Previous"),
                  ),
                if (currentIndex < animalsList.length - 1)
                  ElevatedButton(
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
                    child: Text("Next"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
