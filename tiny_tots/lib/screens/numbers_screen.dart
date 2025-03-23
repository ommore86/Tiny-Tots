import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NumbersScreen(),
  ));
}

class NumbersScreen extends StatelessWidget {
  final List<String> numbers = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Numbers")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return _buildNumberCard(context, numbers[index], index);
        },
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, String number, int index) {
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
              builder: (context) => NumberDetailScreen(number: number, index: index),
            ),
          );
        },
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NumberDetailScreen extends StatelessWidget {
  final String number;
  final int index;

  NumberDetailScreen({Key? key, required this.number, required this.index}) : super(key: key);

  final List<String> numbers = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
  ];

  final Map<String, String> numberExamples = {
    '1': 'One Apple', '2': 'Two Balls', '3': 'Three Cats', '4': 'Four Dogs',
    '5': 'Five Elephants', '6': 'Six Fishes', '7': 'Seven Hats', '8': 'Eight Kites',
    '9': 'Nine Lions', '10': 'Ten Monkeys'
  };

  final Map<String, String> numberImages = {
    '1': 'assets/numbers/1.png',
    '2': 'assets/numbers/2.png',
    '3': 'assets/numbers/3.png',
    '4': 'assets/numbers/4.png',
    '5': 'assets/numbers/5.png',
    '6': 'assets/numbers/6.png',
    '7': 'assets/numbers/7.png',
    '8': 'assets/numbers/8.png',
    '9': 'assets/numbers/9.png',
    '10': 'assets/numbers/10.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details for $number")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          SizedBox(height: 20),

          Image.asset(
            numberImages[number]!,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),

          Text(
            numberExamples[number]!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        builder: (context) => NumberDetailScreen(
                          number: numbers[index - 1], 
                          index: index - 1,
                        ),
                      ),
                    );
                  },
                  child: Text("Previous"),
                ),
              
              if (index < numbers.length - 1)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NumberDetailScreen(
                          number: numbers[index + 1], 
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