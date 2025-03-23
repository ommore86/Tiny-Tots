import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login_screen.dart';
import 'conduct_test_screen.dart';
import 'track_progress_screen.dart';
import 'student_list_screen.dart';
import 'mark_attendance_screen.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String teacherName = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchTeacherName();
  }

  Future<void> _fetchTeacherName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot teacherDoc = await _firestore.collection("users").doc(user.uid).get();
      setState(() {
        teacherName = teacherDoc["name"] ?? "Teacher";
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Teacher's Name Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome, $teacherName",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildDashboardCard(
                    context,
                    "Student List",
                    Icons.list,
                    Colors.orange,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentListScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    "Track Progress",
                    Icons.bar_chart,
                    Colors.green,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => TrackProgressScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    "Conduct Test",
                    Icons.assignment,
                    Colors.blue,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConductTestScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    "Mark Attendance",
                    Icons.check_circle,
                    Colors.purple,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => MarkAttendanceScreen())),
                  ),
                ],
              ),
            ),

            // ✅ Logout Button
            Center(
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Logout", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable Dashboard Card Function
  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        color: color,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
