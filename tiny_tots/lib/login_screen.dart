import 'package:flutter/material.dart';
import 'teacher_login.dart';
import 'parent_login.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo or Illustration
                Image.asset("assets/images/splash_logo.png", height: 140),

                SizedBox(height: 20),

                // Welcome Text
                Text(
                  "Welcome to Tiny Tots 👶🎨",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),

                SizedBox(height: 40),

                // Teacher Login Button
                _buildLoginButton(
                  text: "👩‍🏫 Teacher Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TeacherLogin()),
                    );
                  },
                  color: Colors.purpleAccent,
                ),

                SizedBox(height: 20),

                // Parent Login Button
                _buildLoginButton(
                  text: "👨‍👩‍👦 Parent Login",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ParentLogin(toggleTheme: (bool isDarkMode) {
                      // Add your toggle theme logic here
                    }, isDarkMode: false)));
                  },
                  color: Colors.orangeAccent,
                ),

                SizedBox(height: 30),

                // Signup Option
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({required String text, required VoidCallback onPressed, required Color color}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
          shadowColor: Colors.black26,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}