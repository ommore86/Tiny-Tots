import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Progress")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").where("role", isEqualTo: "Parent").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var students = snapshot.data!.docs;

          if (students.isEmpty) {
            return Center(
              child: Text(
                "No student records found.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var studentData = students[index].data() as Map<String, dynamic>;
              String name = studentData["name"] ?? "Unknown Student";
              int score = studentData.containsKey("score") ? studentData["score"] : 0;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text("Score: $score", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  tileColor: Colors.blue[50],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
