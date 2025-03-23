import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student List", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("users").where("role", isEqualTo: "Parent").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading animation
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No students found!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              );
            }

            var students = snapshot.data!.docs;

            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      student["name"] ?? "Unknown",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      student["email"] ?? "No Email",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
