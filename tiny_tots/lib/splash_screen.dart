import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Show splash screen for 3 seconds, then go to login screen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()), // Redirect to login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageWidth = constraints.maxWidth * 0.8; // 80% of screen width
            double imageHeight = constraints.maxHeight * 0.6; // 60% of screen height

            return Image.asset(
              "assets/splash_logo.png",
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.contain, // Maintain aspect ratio
            );
          },
        ),
      ),
    );
  }
}