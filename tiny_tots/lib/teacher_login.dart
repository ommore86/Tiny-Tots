import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/teacher_dashboard.dart';

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc["role"];

        if (role == "Teacher") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Successful!"), backgroundColor: Colors.green),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TeacherDashboard()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Access Denied: Only Teachers can log in!"), backgroundColor: Colors.red),
          );
          await _auth.signOut();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found in database!"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetPassword() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email!"), backgroundColor: Colors.orange),
      );
      return;
    }

    try {
      // 🔍 Check if the email exists in Firestore as a Teacher
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .where("role", isEqualTo: "Teacher") // Ensure it's a Teacher
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // ✅ Email is found as a Teacher, send reset email
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset email sent! Check your inbox."), backgroundColor: Colors.blue),
        );
      } else {
        // ❌ Email not found or not a Teacher
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "No teacher account found with this email. Please contact admin or check your email."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.purple),
                ),
                SizedBox(height: 20),

                Text(
                  "Teacher Login",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                _buildTextField(
                  controller: emailController,
                  label: "Email",
                  icon: Icons.email,
                ),
                SizedBox(height: 15),

                _buildTextField(
                  controller: passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Login",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                SizedBox(height: 20),

                TextButton(
                  onPressed: _resetPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purpleAccent),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
