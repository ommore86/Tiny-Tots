import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load theme preference before running app
  bool isDarkMode = await _getThemePreference();

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  MyApp({required this.isDarkMode});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    _saveThemePreference(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(toggleTheme: () => _toggleTheme(!_isDarkMode), isDarkMode: _isDarkMode), // Wrapping _toggleTheme to match VoidCallback
    );
  }
}

// Function to get the saved theme preference
Future<bool> _getThemePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("darkMode") ?? false;
}

// Function to save the theme preference
Future<void> _saveThemePreference(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("darkMode", value);
}
