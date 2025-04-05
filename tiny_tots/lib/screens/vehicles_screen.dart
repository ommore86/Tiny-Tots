import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VehiclesScreen extends StatelessWidget {
  final List<Map<String, String>> vehiclesList = [
    {'name': 'Bicycle', 'image': 'assets/images/vehicles/bicycle.png'},
    {'name': 'Boat', 'image': 'assets/images/vehicles/boat.png'},
    {'name': 'Bus', 'image': 'assets/images/vehicles/bus.png'},
    {'name': 'Car', 'image': 'assets/images/vehicles/car.png'},
    {'name': 'Helicopter', 'image': 'assets/images/vehicles/helicopter.png'},
    {'name': 'Airplane', 'image': 'assets/images/vehicles/plane.png'},
    {'name': 'Scooter', 'image': 'assets/images/vehicles/scooter.png'},
    {'name': 'Train', 'image': 'assets/images/vehicles/train.png'},
    {'name': 'Truck', 'image': 'assets/images/vehicles/truck.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicles", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: vehiclesList.length,
          itemBuilder: (context, index) {
            return _buildVehicleCard(context, vehiclesList[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, Map<String, String> vehicleData, int index) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleDetailScreen(
                vehiclesList: vehiclesList,
                currentIndex: index,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: vehicleData['name']!,
              child: Image.asset(vehicleData['image']!, width: 100, height: 100),
            ),
            SizedBox(height: 10),
            Text(
              vehicleData['name']!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleDetailScreen extends StatefulWidget {
  final List<Map<String, String>> vehiclesList;
  final int currentIndex;

  VehicleDetailScreen({Key? key, required this.vehiclesList, required this.currentIndex}) : super(key: key);

  @override
  _VehicleDetailScreenState createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> _speakSpelling(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.2);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> vehicleData = widget.vehiclesList[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(vehicleData['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: vehicleData['name']!,
                child: Image.asset(vehicleData['image']!, width: 200, height: 200),
              ),
              SizedBox(height: 20),
              Text(
                vehicleData['name']!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal.shade900),
              ),
              SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () => _speakSpelling(vehicleData['name']!),
                icon: Icon(Icons.volume_up, color: Colors.white),
                label: Text("Play Spelling"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.currentIndex > 0)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleDetailScreen(
                              vehiclesList: widget.vehiclesList,
                              currentIndex: widget.currentIndex - 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text("Previous"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    ),
                  if (widget.currentIndex < widget.vehiclesList.length - 1)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleDetailScreen(
                              vehiclesList: widget.vehiclesList,
                              currentIndex: widget.currentIndex + 1,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Next"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
