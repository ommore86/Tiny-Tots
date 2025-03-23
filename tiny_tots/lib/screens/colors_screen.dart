import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Colors")),
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
      elevation: 5,
      color: colorsList[index]['color'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
        child: Center(
          child: Text(
            colorsList[index]['name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ColorDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> colorsList;
  final int currentIndex;

  ColorDetailScreen({Key? key, required this.colorsList, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details for ${colorsList[currentIndex]['name']}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              colorsList[currentIndex]['name'],
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: colorsList[currentIndex]['color']),
            ),
            SizedBox(height: 20),

            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: colorsList[currentIndex]['color'],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
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
            ElevatedButton(
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
                  : null, // Disable button if first color
              child: Text("Previous"),
            ),
            ElevatedButton(
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
                  : null, // Disable button if last color
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}