import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Student List",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("users").where("role", isEqualTo: "Parent").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No students found!",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
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
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    title: Text(
                      student["name"] ?? "Unknown",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      student["email"] ?? "No Email",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    tileColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentDetailScreen(student: student),
                        ),
                      );
                    },
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

class StudentDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot student;

  StudentDetailScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Student Details", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text("Name: ${student["name"] ?? "Unknown"}", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Email: ${student["email"] ?? "No Email"}", style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[800])),
                SizedBox(height: 10),
                // Text("Score: ${student["score"] ?? "Not Available"}", style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[800])),
                // SizedBox(height: 10),
                // Text("Grade: ${student["grade"] ?? "Not Available"}", style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[800])),
                // SizedBox(height: 10),
                // Text("Parent Contact: ${student["parent_contact"] ?? "Not Available"}", style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[800])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
