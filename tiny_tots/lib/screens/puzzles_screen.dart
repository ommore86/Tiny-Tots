import 'package:flutter/material.dart';
import 'dart:math';

class MatchingPairsPuzzle extends StatefulWidget {
  const MatchingPairsPuzzle({Key? key}) : super(key: key);

  @override
  State<MatchingPairsPuzzle> createState() => _MatchingPairsPuzzleState();
}

class _MatchingPairsPuzzleState extends State<MatchingPairsPuzzle> {
  final List<Map<String, String>> currentItems = [
    // Fruits
    {'name': 'Apple', 'image': 'assets/images/fruits/apple.png'},
    {'name': 'Banana', 'image': 'assets/images/fruits/banana.png'},
    {'name': 'Cherry', 'image': 'assets/images/fruits/cherry.png'},
    {'name': 'Grapes', 'image': 'assets/images/fruits/grape.png'},
    {'name': 'Kiwi', 'image': 'assets/images/fruits/kiwi.png'},
    {'name': 'Mango', 'image': 'assets/images/fruits/mango.png'},
    {'name': 'Orange', 'image': 'assets/images/fruits/orange.png'},
    {'name': 'Pear', 'image': 'assets/images/fruits/pear.png'},
    {'name': 'Pineapple', 'image': 'assets/images/fruits/pineapple.png'},
    {'name': 'Strawberry', 'image': 'assets/images/fruits/strawberry.png'},

    //Animals
    {'name': 'Bear', 'image': 'assets/images/animals/bear.png'},
    {'name': 'Cat', 'image': 'assets/images/animals/cat.png'},
    {'name': 'Dog', 'image': 'assets/images/animals/dog.png'},
    {'name': 'Elephant', 'image': 'assets/images/animals/elephant.png'},
    {'name': 'Giraffe', 'image': 'assets/images/animals/giraffe.png'},
    {'name': 'Lion', 'image': 'assets/images/animals/lion.png'},
    {'name': 'Monkey', 'image': 'assets/images/animals/monkey.png'},
    {'name': 'Rabbit', 'image': 'assets/images/animals/rabbit.png'},
    {'name': 'Tiger', 'image': 'assets/images/animals/tiger.png'},
    {'name': 'Zebra', 'image': 'assets/images/animals/zebra.png'},

    //Birds
    {'name': 'Crow', 'image': 'assets/images/birds/crow.png'},
    {'name': 'Duck', 'image': 'assets/images/birds/duck.png'},
    {'name': 'Eagle', 'image': 'assets/images/birds/eagle.png'},
    {'name': 'Owl', 'image': 'assets/images/birds/owl.png'},
    {'name': 'Parrot', 'image': 'assets/images/birds/parrot.png'},
    {'name': 'Peacock', 'image': 'assets/images/birds/peacock.png'},
    {'name': 'Penguin', 'image': 'assets/images/birds/penguin.png'},
    {'name': 'Sparrow', 'image': 'assets/images/birds/sparrow.png'},
    {'name': 'Swan', 'image': 'assets/images/birds/swan.png'},

    // Colors
    {'name': 'Red', 'image': 'assets/images/colors/red.png'},
    {'name': 'Blue', 'image': 'assets/images/colors/blue.png'},
    {'name': 'Green', 'image': 'assets/images/colors/green.png'},
    {'name': 'Yellow', 'image': 'assets/images/colors/yellow.png'},
    {'name': 'Purple', 'image': 'assets/images/colors/purple.png'},
    {'name': 'Orange', 'image': 'assets/images/colors/orange.png'},
    {'name': 'Pink', 'image': 'assets/images/colors/pink.png'},
    {'name': 'Brown', 'image': 'assets/images/colors/brown.png'},
    {'name': 'Black', 'image': 'assets/images/colors/black.png'},
    {'name': 'White', 'image': 'assets/images/colors/white.png'},

    // Shapes
    {'name': 'Circle', 'image': 'assets/images/shapes/circle.png'},
    {'name': 'Square', 'image': 'assets/images/shapes/square.png'},
    {'name': 'Triangle', 'image': 'assets/images/shapes/triangle.png'},
    {'name': 'Rectangle', 'image': 'assets/images/shapes/rectangle.png'},
    {'name': 'Oval', 'image': 'assets/images/shapes/oval.png'},
    {'name': 'Diamond', 'image': 'assets/images/shapes/diamond.png'},
    {'name': 'Star', 'image': 'assets/images/shapes/star.png'},
    {'name': 'Pentagon', 'image': 'assets/images/shapes/pentagon.png'},
    {'name': 'Hexagon', 'image': 'assets/images/shapes/hexagon.png'},

    // Toys
    {'name': 'Car', 'image': 'assets/images/toys/car.png'},
    {'name': 'Doll', 'image': 'assets/images/toys/doll.png'},
    {'name': 'Ball', 'image': 'assets/images/toys/ball.png'},
    {'name': 'Teddy Bear', 'image': 'assets/images/toys/teddy.png'},
    {'name': 'Puzzle', 'image': 'assets/images/toys/puzzle.png'},
    {'name': 'Train', 'image': 'assets/images/toys/train.png'},
    {'name': 'Robot', 'image': 'assets/images/toys/robot.png'},

    // Vehicles
    {'name': 'Bicycle', 'image': 'assets/images/vehicles/bicycle.png'},
    {'name': 'boat', 'image': 'assets/images/vehicles/boat.png'},
    {'name': 'Bus', 'image': 'assets/images/vehicles/bus.png'},
    {'name': 'Car', 'image': 'assets/images/vehicles/car.png'},
    {'name': 'Helicopter', 'image': 'assets/images/vehicles/helicopter.png'},
    {'name': 'Airplane', 'image': 'assets/images/vehicles/plane.png'},
    {'name': 'Scooter', 'image': 'assets/images/vehicles/scooter.png'},    
    {'name': 'Ship', 'image': 'assets/images/vehicles/ship.png'},    
    {'name': 'Truck', 'image': 'assets/images/vehicles/truck.png'},
    {'name': 'Train', 'image': 'assets/images/vehicles/train.png'},
  ];

  List<_CardItem> nameCards = [];
  List<_CardItem> imageCards = [];
  bool allMatched = false;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    nameCards = currentItems.map((item) => _CardItem(text: item['name']!)).toList();
    imageCards = currentItems.map((item) => _CardItem(text: item['name']!, image: item['image']!)).toList();

    nameCards.shuffle(Random());
    imageCards.shuffle(Random());
  }

  void _checkAllMatched() {
    setState(() {
      allMatched = nameCards.every((card) => card.matched) &&
          imageCards.every((card) => card.matched);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match the Pairs'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Row(
        children: [
          // Left side: Images
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: imageCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final card = imageCards[index];
                return Draggable<String>(
                  data: card.text!, // Drag the "name" (not the image)
                  feedback: Material(
                    child: Image.asset(card.image!, width: 80),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: _buildImageCard(card),
                  ),
                  child: _buildImageCard(card),
                );
              },
            ),
          ),
          // Right side: Names
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: nameCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final card = nameCards[index];
                return DragTarget<String>(
                  onAccept: (receivedName) {
                    if (receivedName == card.text) {
                      setState(() {
                        card.matched = true;
                        imageCards.firstWhere((imgCard) => imgCard.text == receivedName).matched = true;
                      });
                      _checkAllMatched();
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: card.matched ? Colors.green[200] : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        card.text!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: allMatched
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                onPressed: () {
                  setState(() {
                    _loadCards();
                    allMatched = false;
                  });
                },
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildImageCard(_CardItem card) {
    return Container(
      decoration: BoxDecoration(
        color: card.matched ? Colors.green[200] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(8),
      child: card.image != null
          ? Image.asset(card.image!, fit: BoxFit.contain)
          : const SizedBox.shrink(),
    );
  }
}

class _CardItem {
  String? text;
  String? image;
  bool matched = false;

  _CardItem({this.text, this.image});
}
