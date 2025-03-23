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
    _tabController = TabController(length: 2, vsync: this); // 2 Tabs (Teacher & Parent)
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
        "role": role, // Stores role as "Teacher" or "Parent"
        "createdAt": FieldValue.serverTimestamp(), // Store timestamp
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$role Signup Successful")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Column(
        children: [
          // Tab Bar for Teacher & Parent Signup
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Teacher Signup"),
              Tab(text: "Parent Signup"),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSignupForm("Teacher", context), // Teacher Signup Form
                _buildSignupForm("Parent", context),  // Parent Signup Form
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(String role, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Full Name"),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => signup(role), // Call signup with the respective role
            child: Text("Sign Up as $role"),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => role == "Teacher" ? TeacherLogin() : ParentLogin(),
                ),
              );
            },
            child: Text("Already have an account? Login as $role"),
          ),
        ],
      ),
    );
  }
}
