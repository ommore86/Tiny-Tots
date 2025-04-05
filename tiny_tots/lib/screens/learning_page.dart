import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'alphabets_screen.dart';
import 'numbers_screen.dart';
import 'shapes_screen.dart';
import 'colors_screen.dart';
import 'animals_screen.dart';
import 'birds_screen.dart';
import 'fruits_screen.dart';
import 'food_screen.dart';
import 'vehicles_screen.dart';
import 'toys_screen.dart';
import 'emotions_screen.dart';

class LearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.orange.shade100, Colors.orange.shade300]),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Learn Categories"),
              _buildGrid(context, learningItems, 3),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.brown),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> items, int crossAxisCount) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item["page"])),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(item["imagePath"], width: 50, height: 50),
                SizedBox(height: 8),
                Text(item["title"],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}

final List<Map<String, dynamic>> learningItems = [
  {"title": "Alphabets", "imagePath": "assets/images/alphabets.png", "page": AlphabetsScreen()},
  {"title": "Numbers", "imagePath": "assets/images/numbers.png", "page": NumbersScreen()},
  {"title": "Shapes", "imagePath": "assets/images/shapes.png", "page": ShapesScreen()},
  {"title": "Colors", "imagePath": "assets/images/colors.png", "page": ColorsScreen()},
  {"title": "Animals", "imagePath": "assets/images/animals.png", "page": AnimalsScreen()},
  {"title": "Birds", "imagePath": "assets/images/birds.png", "page": BirdsScreen()},
  {"title": "Fruits", "imagePath": "assets/images/fruits.png", "page": FruitsScreen()},
  {"title": "Food", "imagePath": "assets/images/food.png", "page": FoodScreen()},
  {"title": "Vehicles", "imagePath": "assets/images/vehicles.png", "page": VehiclesScreen()},
  {"title": "Toys", "imagePath": "assets/images/toys.png", "page": ToysScreen()},
  {"title": "Emotions", "imagePath": "assets/images/emotions.png", "page": EmotionsScreen()},
  // You can add more to make it 4x4 (16 total)
];