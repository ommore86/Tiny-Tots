import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For formatting dates

class MarkAttendanceScreen extends StatefulWidget {
  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Get today's date

  Future<void> _markAttendance(String studentId, String status) async {
    await _firestore.collection("attendance").doc(studentId).collection("records").doc(currentDate).set({
      "status": status,
      "timestamp": FieldValue.serverTimestamp(),
    });

    setState(() {}); // Refresh UI after marking attendance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mark Attendance")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("users").where("role", isEqualTo: "Parent").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var students = snapshot.data!.docs;
          if (students.isEmpty) {
            return Center(
              child: Text("No students found.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
            );
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var studentData = students[index].data() as Map<String, dynamic>;
              String studentId = students[index].id;
              String name = studentData["name"] ?? "Unknown Student";

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text("Tap to view attendance history", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  children: [
                    // Attendance History
                    FutureBuilder<QuerySnapshot>(
                      future: _firestore.collection("attendance").doc(studentId).collection("records").get(),
                      builder: (context, historySnapshot) {
                        if (!historySnapshot.hasData) return Center(child: CircularProgressIndicator());

                        var history = historySnapshot.data!.docs;
                        if (history.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("No attendance records yet.", style: TextStyle(fontSize: 14, color: Colors.grey)),
                          );
                        }

                        return Column(
                          children: history.map((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(doc.id, style: TextStyle(fontWeight: FontWeight.bold)), // Date
                              subtitle: Text(data["status"], style: TextStyle(color: data["status"] == "Present" ? Colors.green : Colors.red)),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    SizedBox(height: 10),

                    // Mark Attendance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAttendanceButton("Present", Colors.green, studentId),
                        _buildAttendanceButton("Absent", Colors.red, studentId),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAttendanceButton(String label, Color color, String studentId) {
    return ElevatedButton(
      onPressed: () => _markAttendance(studentId, label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
