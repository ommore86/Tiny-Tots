import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShapesScreen(),
  ));
}

class ShapesScreen extends StatelessWidget {
  final List<String> shapes = [
    'Circle', 'Square', 'Triangle', 'Rectangle', 'Star', 'Oval', 'Pentagon', 'Hexagon', 'Diamond'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Shapes", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: shapes.length,
          itemBuilder: (context, index) {
            return _buildShapeCard(context, shapes[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildShapeCard(BuildContext context, String shape, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShapeDetailScreen(shape: shape, index: index),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.pinkAccent, Colors.orangeAccent]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              shape,
              style: GoogleFonts.fredoka(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ShapeDetailScreen extends StatelessWidget {
  final String shape;
  final int index;

  ShapeDetailScreen({Key? key, required this.shape, required this.index}) : super(key: key);

  final List<String> shapes = [
    'Circle', 'Square', 'Triangle', 'Rectangle', 'Star', 'Oval', 'Pentagon', 'Hexagon', 'Diamond'
  ];

  final Map<String, String> shapeImages = {
    'Circle': 'assets/images/shapes/circle.png',
    'Square': 'assets/images/shapes/square.png',
    'Triangle': 'assets/images/shapes/triangle.png',
    'Rectangle': 'assets/images/shapes/rectangle.png',
    'Star': 'assets/images/shapes/star.png',
    'Oval': 'assets/images/shapes/oval.png',
    'Pentagon': 'assets/images/shapes/pentagon.png',
    'Hexagon': 'assets/images/shapes/hexagon.png',
    'Diamond': 'assets/images/shapes/diamond.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(shape, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            shape,
            style: GoogleFonts.fredoka(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Image.asset(
              shapeImages[shape] ?? 'assets/images/shapes/circle.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (index > 0)
                FloatingActionButton(
                  heroTag: "prev",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShapeDetailScreen(
                          shape: shapes[index - 1],
                          index: index - 1,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),

              if (index < shapes.length - 1)
                FloatingActionButton(
                  heroTag: "next",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShapeDetailScreen(
                          shape: shapes[index + 1],
                          index: index + 1,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
