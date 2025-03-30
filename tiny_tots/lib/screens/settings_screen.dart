import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:share_plus/share_plus.dart'; // Import Share Package
import 'package:url_launcher/url_launcher.dart'; // Import URL Launcher
import 'package:tiny_tots/login_screen.dart'; // Import your login screen

class SettingsScreen extends StatefulWidget {
  final String userRole;

  SettingsScreen({required this.userRole});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isSoundOn = true;
  bool notificationsEnabled = true;
  String userName = "Loading...";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _loadPreferences();
  }

  /// Fetch user info from Firestore
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

  /// Load user preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSoundOn = prefs.getBool('isSoundOn') ?? true;
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  void _toggleSound(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSoundOn', value);
  setState(() {
    isSoundOn = value;
  });
}

  void _toggleNotifications(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('notificationsEnabled', value);
  setState(() {
    notificationsEnabled = value;
  });
}

  void _logout() async {
    bool confirmLogout = await _showLogoutConfirmation();
    if (confirmLogout) {
      await _auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  /// Build a switch tile widget
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      secondary: Icon(icon, color: Colors.blueAccent),
      value: value,
      onChanged: onChanged,
    );
  }

  Future<bool> _showLogoutConfirmation() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Logout", style: TextStyle(color: Colors.red))),
        ],
      ),
    ) ?? false;
  }

  void _shareApp() {
    Share.share("Check out Tiny Tots Learning App: https://example.com");
  }

  void _giveFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@tinytots.com',
      queryParameters: {
        'subject': 'Feedback on Tiny Tots App',
      },
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open email app")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  title: Text(userName,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                  subtitle: Text(userEmail, style: TextStyle(color: Colors.black54)),
                ),
              ),
              SizedBox(height: 20),

              _buildSwitchTile(
                title: "Enable Notifications",
                subtitle: "Receive updates and alerts",
                icon: Icons.notifications,
                value: notificationsEnabled,
                onChanged: _toggleNotifications,
              ),

              _buildSwitchTile(
                title: "Sound",
                subtitle: "Turn on/off app sounds",
                icon: Icons.volume_up,
                value: isSoundOn,
                onChanged: _toggleSound,
              ),

              SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _shareApp,
                icon: Icon(Icons.share, color: Colors.white),
                label: Text("Share App"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: _giveFeedback,
                icon: Icon(Icons.feedback, color: Colors.white),
                label: Text("Give Feedback"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
              ),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
                child: Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
