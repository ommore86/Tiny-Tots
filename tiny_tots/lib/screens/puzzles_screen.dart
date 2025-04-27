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
    {'name': 'Eagle', 'image': 'assets/images/birds/eagle.png'},
    {'name': 'Parrot', 'image': 'assets/images/birds/parrot.png'},
    {'name': 'Penguin', 'image': 'assets/images/birds/penguin.png'},
    {'name': 'Sparrow', 'image': 'assets/images/birds/sparrow.png'},
    {'name': 'Peacock', 'image': 'assets/images/birds/peacock.png'},
    {'name': 'Owl', 'image': 'assets/images/birds/owl.png'},
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
