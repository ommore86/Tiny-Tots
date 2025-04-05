import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiny_tots/screens/teacher_dashboard.dart'; // Teacher Dashboard
import 'package:tiny_tots/screens/home_screen.dart'; // Parent Home Screen
import 'login_screen.dart'; // Login Screen

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const SplashScreen({
    required this.toggleTheme,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Show splash screen for 3 seconds

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Fetch user role from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          String? role = userDoc["role"];

          if (mounted) {
            if (role == "Teacher") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => TeacherDashboard()),
              );
            } else if (role == "Parent") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(
                    toggleTheme: (bool _) => widget.toggleTheme(),
                    isDarkMode: widget.isDarkMode,
                    userRole: role!,
                  ),
                ),
              );
            } else {
              _redirectToLogin();
            }
          }
        } else {
          _redirectToLogin();
        }
      } catch (e) {
        print("Error fetching user role: $e");
        _redirectToLogin();
      }
    } else {
      _redirectToLogin();
    }
  }

  void _redirectToLogin() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/splash_logo.png",
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
