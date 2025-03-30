import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'teacher_login.dart';
import 'parent_login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TabController _tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> signup(String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Store user details in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": emailController.text.trim(),
        "name": nameController.text.trim(),
        "role": role,
        "createdAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$role Signup Successful"), backgroundColor: Colors.green),
      );

      // Navigate to the appropriate login screen after signup
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => role == "Teacher"
                ? TeacherLogin()
                : ParentLogin(isDarkMode: false, toggleTheme: (bool isDark) {}),
                      ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Failed: $e"), backgroundColor: Colors.red),
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
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              "Create an Account",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Tab Bar for Teacher & Parent Signup
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Teacher Signup"),
                Tab(text: "Parent Signup"),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSignupForm("Teacher", context),
                  _buildSignupForm("Parent", context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm(String role, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextField(
            controller: nameController,
            label: "Full Name",
            icon: Icons.person,
          ),
          SizedBox(height: 15),
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

          // Signup Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => signup(role),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
              child: Text(
                "Sign Up as $role",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Login Option
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => role == "Teacher" 
                      ? TeacherLogin() 
                      : ParentLogin(isDarkMode: false, toggleTheme: (bool isDark) {}),
                ),
              );
            },
            child: Text(
              "Already have an account? Login as $role",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
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