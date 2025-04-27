import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'settings_screen.dart';
import 'poems_screen.dart';
import 'exercises_screen.dart';
import 'games_screen.dart';
import 'puzzles_screen.dart';
import 'learning_page.dart'; 

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
              ? LinearGradient(colors: [Colors.black87, Colors.black54])
              : LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent]),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSectionTitle("Learning"),
                      _buildGrid(context, learningNavigationItem, 2),
                      SizedBox(height: 20),
                      _buildSectionTitle("Fun & Activities"),
                      _buildGrid(context, funItems, 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("TinyTots Learning",
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen(userRole: userRole)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<Map<String, dynamic>> items, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildMenuItem(context, item["title"]!, item["imagePath"]!, item["page"]!);
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(title,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> learningNavigationItem = [
  {
    "title": "Learning",
    "imagePath": "assets/images/learning.png",
    "page": LearningPage(),
  },
];

final List<Map<String, dynamic>> funItems = [
  {"title": "Poems", "imagePath": "assets/images/poems.png", "page": PoemsScreen()},
  {"title": "Exercises", "imagePath": "assets/images/exercise.png", "page": ExercisesScreen()},
  {"title": "Games", "imagePath": "assets/images/games.png", "page": GamesHomeScreen()},
  {"title": "Puzzles", "imagePath": "assets/images/puzzles.png", "page": PuzzlesScreen()},
];
