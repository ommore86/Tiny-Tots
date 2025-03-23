import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Shapes")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
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
    );
  }

  Widget _buildShapeCard(BuildContext context, String shape, int index) {
    return Card(
      elevation: 5,
      color: Colors.pink[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShapeDetailScreen(shape: shape, index: index),
            ),
          );
        },
        child: Center(
          child: Text(
            shape,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
      appBar: AppBar(title: Text("Details for $shape")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            shape,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          SizedBox(height: 20),

          Image.asset(
            shapeImages[shape] ?? 'assets/images/shapes/circle.png',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),

          // ✅ Next & Previous Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (index > 0)
                ElevatedButton(
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
                  child: Text("Previous"),
                ),
              
              if (index < shapes.length - 1)
                ElevatedButton(
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
                  child: Text("Next"),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
