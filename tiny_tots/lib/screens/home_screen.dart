import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
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
  final Function(bool) toggleTheme;
  final bool isDarkMode;
  final String userRole;

  HomeScreen({
    required this.toggleTheme,
    required this.isDarkMode,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(colors: [Colors.black87, Colors.black54], begin: Alignment.topLeft, end: Alignment.bottomRight)
              : LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            // Custom App Bar with Gradient
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TinyTots Learning",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(userRole: userRole),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: menuItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return _buildMenuItem(context, item["title"]!, item["imagePath"]!, item["page"]!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 50, color: Colors.red);
                },
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Menu items list for cleaner code
final List<Map<String, dynamic>> menuItems = [
  {"title": "Alphabets", "imagePath": "assets/images/alphabets.png", "page": AlphabetsScreen()},
  {"title": "Numbers", "imagePath": "assets/images/numbers.png", "page": NumbersScreen()},
  {"title": "Shapes", "imagePath": "assets/images/shapes.png", "page": ShapesScreen()},
  {"title": "Colors", "imagePath": "assets/images/colors.png", "page": ColorsScreen()},
  {"title": "Animals", "imagePath": "assets/images/animals.png", "page": AnimalsScreen()},
  {"title": "Birds", "imagePath": "assets/images/birds.png", "page": BirdsScreen()},
  {"title": "Poems", "imagePath": "assets/images/poems.png", "page": PoemsScreen()},
  {"title": "Exercises", "imagePath": "assets/images/exercise.png", "page": ExercisesScreen()},
  {"title": "Games", "imagePath": "assets/images/games.png", "page": GamesScreen()},
  {"title": "Puzzles", "imagePath": "assets/images/puzzles.png", "page": PuzzlesScreen()},
];
