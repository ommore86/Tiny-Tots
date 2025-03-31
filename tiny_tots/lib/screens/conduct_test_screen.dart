import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For formatting dates

class ConductTestScreen extends StatefulWidget {
  @override
  _ConductTestScreenState createState() => _ConductTestScreenState();
}

class _ConductTestScreenState extends State<ConductTestScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController testNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int questionCount = 5;
  DateTime selectedDate = DateTime.now();

  Future<void> _submitTest() async {
    if (testNameController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields.")));
      return;
    }

    await _firestore.collection("tests").add({
      "testName": testNameController.text.trim(),
      "description": descriptionController.text.trim(),
      "date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "questions": questionCount,
      "createdAt": FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Test Created Successfully!")));
    setState(() {
      testNameController.clear();
      descriptionController.clear();
      questionCount = 5;
      selectedDate = DateTime.now();
    });
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _openTestDetails(String testId, String testName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TestDetailsScreen(testId: testId, testName: testName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conduct Test")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create New Test", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            
            TextField(
              controller: testNameController,
              decoration: InputDecoration(
                labelText: "Test Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Test Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}", style: TextStyle(fontSize: 16)),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text("Pick Date"),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Number of Questions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Number of Questions: $questionCount", style: TextStyle(fontSize: 16)),
                Slider(
                  value: questionCount.toDouble(),
                  min: 5,
                  max: 20,
                  divisions: 15,
                  label: questionCount.toString(),
                  onChanged: (value) {
                    setState(() {
                      questionCount = value.toInt();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: _submitTest,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: Text("Create Test", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            SizedBox(height: 30),

            // Display Past Tests
            Text("Previous Tests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("tests").orderBy("createdAt", descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  var tests = snapshot.data!.docs;
                  if (tests.isEmpty) {
                    return Center(child: Text("No tests found.", style: TextStyle(color: Colors.grey)));
                  }

                  return ListView.builder(
                    itemCount: tests.length,
                    itemBuilder: (context, index) {
                      var test = tests[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(test["testName"], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("Date: ${test["date"]}\nQuestions: ${test["questions"]}\n${test["description"]}"),
                          isThreeLine: true,
                          onTap: () => _openTestDetails(tests[index].id, test["testName"]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestDetailsScreen extends StatelessWidget {
  final String testId;
  final String testName;

  TestDetailsScreen({required this.testId, required this.testName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Details: $testName")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var students = snapshot.data!.docs;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var student = students[index];
              return ListTile(
                title: Text(student["name"] ?? "Unknown"),
                subtitle: Text("Status: Absent"),
              );
            },
          );
        },
      ),
    );
  }
}
