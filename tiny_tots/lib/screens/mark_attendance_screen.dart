import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkAttendanceScreen extends StatefulWidget {
  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> _markAttendance(String studentId, String status) async {
    await _firestore.collection("attendance").doc(studentId).collection("records").doc(currentDate).set({
      "status": status,
      "timestamp": FieldValue.serverTimestamp(),
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Mark Attendance", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("users").where("role", isEqualTo: "Parent").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
            }

            var students = snapshot.data!.docs;
            if (students.isEmpty) {
              return Center(
                child: Text("No students found.", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
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
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Text("Tap to view attendance history", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                    children: [
                      FutureBuilder<QuerySnapshot>(
                        future: _firestore.collection("attendance").doc(studentId).collection("records").get(),
                        builder: (context, historySnapshot) {
                          if (!historySnapshot.hasData) return Center(child: CircularProgressIndicator());

                          var history = historySnapshot.data!.docs;
                          if (history.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("No attendance records yet.", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                            );
                          }

                          return Column(
                            children: history.map((doc) {
                              var data = doc.data() as Map<String, dynamic>;
                              return ListTile(
                                leading: Icon(
                                  data["status"] == "Present" ? Icons.check_circle : Icons.cancel,
                                  color: data["status"] == "Present" ? Colors.green : Colors.red,
                                ),
                                title: Text(doc.id, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                                subtitle: Text(data["status"], style: GoogleFonts.poppins(color: Colors.black87)),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(height: 10),
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
      ),
    );
  }

  Widget _buildAttendanceButton(String label, Color color, String studentId) {
    return ElevatedButton(
      onPressed: () => _markAttendance(studentId, label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      ),
      child: Text(label, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
