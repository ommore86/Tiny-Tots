import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final String userRole;

  SettingsScreen({required this.userRole}); // Accept user role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings for $userRole",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            if (userRole == "Parent") _parentSettings(),
            if (userRole == "Teacher") _teacherSettings(),
            if (userRole == "Student") _studentSettings(),
          ],
        ),
      ),
    );
  }

  Widget _parentSettings() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Manage Child's Progress"),
          subtitle: Text("Track learning progress and reports"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text("Parental Controls"),
          subtitle: Text("Restrict content & app usage"),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _teacherSettings() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.upload),
          title: Text("Upload Learning Materials"),
          subtitle: Text("Add study materials and assignments"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text("Manage Students"),
          subtitle: Text("View and assess student progress"),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _studentSettings() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profile"),
          subtitle: Text("Edit your personal details"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.volume_up),
          title: Text("Audio Assistance"),
          subtitle: Text("Enable voice support for learning"),
          onTap: () {},
        ),
      ],
    );
  }
}
