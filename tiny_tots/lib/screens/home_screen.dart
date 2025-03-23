import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'alphabets_screen.dart';
import 'numbers_screen.dart';
import 'shapes_screen.dart';
import 'colors_screen.dart';
import 'animals_screen.dart';
import 'birds_screen.dart';
import 'poems_screen.dart';
import 'exercises_screen.dart';
import 'games_screen.dart';
import 'puzzles_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userRole = "Student"; // Change to "Parent" or "Teacher" accordingly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC1E3),
      appBar: AppBar(
        title: Text("TinyTots Learning App"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen(userRole: userRole)),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: [
          _buildMenuItem(context, "Alphabets", "assets/images/alphabets.png", AlphabetsScreen()),
          _buildMenuItem(context, "Numbers", "assets/images/numbers.png", NumbersScreen()),
          _buildMenuItem(context, "Shapes", "assets/images/shapes.png", ShapesScreen()),
          _buildMenuItem(context, "Colors", "assets/images/colors.png", ColorsScreen()),
          _buildMenuItem(context, "Animals", "assets/images/animals.png", AnimalsScreen()),
          _buildMenuItem(context, "Birds", "assets/images/birds.png", BirdsScreen()),
          _buildMenuItem(context, "Poems", "assets/images/poems.png", PoemsScreen()),
          _buildMenuItem(context, "Exercises", "assets/images/exercise.png", ExercisesScreen()),
          _buildMenuItem(context, "Games", "assets/images/games.png", GamesScreen()),
          _buildMenuItem(context, "Puzzles", "assets/images/puzzles.png", PuzzlesScreen()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String imagePath, Widget page) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 100, // Reduced size for better UI
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported, size: 50, color: Colors.red);
              },
            ),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
