import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  final String userRole;

  SettingsScreen({required this.userRole});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  bool isDarkMode = false;
  bool isSoundOn = true;
  bool notificationsEnabled = true;
  String userName = "Loading...";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();
      setState(() {
        userName = userDoc["name"] ?? "User";
        userEmail = userDoc["email"] ?? "No email available";
      });
    }
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void _toggleSound(bool value) {
    setState(() {
      isSoundOn = value;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Section
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  title: Text(userName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(userEmail),
                ),
              ),
              SizedBox(height: 20),

              // Notification Toggle
              _buildSwitchTile(
                title: "Enable Notifications",
                subtitle: "Receive updates and alerts",
                icon: Icons.notifications,
                value: notificationsEnabled,
                onChanged: _toggleNotifications,
              ),

              // Sound Toggle
              _buildSwitchTile(
                title: "Sound",
                subtitle: "Turn on/off app sounds",
                icon: Icons.volume_up,
                value: isSoundOn,
                onChanged: _toggleSound,
              ),

              // Dark Mode Toggle
              _buildSwitchTile(
                title: "Dark Mode",
                subtitle: "Enable dark theme",
                icon: Icons.dark_mode,
                value: isDarkMode,
                onChanged: _toggleDarkMode,
              ),

              // Share App Option

              // Contact Developer Option
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Function for Switch Tiles
  Widget _buildSwitchTile({required String title, required String subtitle, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SwitchListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        secondary: Icon(icon, color: Colors.blueAccent),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // Reusable Function for List Tiles
  Widget _buildListTile({required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}