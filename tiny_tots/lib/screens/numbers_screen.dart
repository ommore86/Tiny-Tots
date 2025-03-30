import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NumbersScreen(),
  ));
}

class NumbersScreen extends StatelessWidget {
  final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Numbers", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.deepPurple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return _buildNumberCard(context, numbers[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, String number, int index) {
    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.deepPurple),
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

  final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  final Map<String, String> numberExamples = {
    '1': 'One Apple', '2': 'Two Balls', '3': 'Three Cats', '4': 'Four Dogs',
    '5': 'Five Elephants', '6': 'Six Fishes', '7': 'Seven Hats', '8': 'Eight Kites',
    '9': 'Nine Lions', '10': 'Ten Monkeys'
  };

  final Map<String, String> numberImages = {
    '1': 'assets/numbers/1.png', '2': 'assets/numbers/2.png', '3': 'assets/numbers/3.png',
    '4': 'assets/numbers/4.png', '5': 'assets/numbers/5.png', '6': 'assets/numbers/6.png',
    '7': 'assets/numbers/7.png', '8': 'assets/numbers/8.png', '9': 'assets/numbers/9.png',
    '10': 'assets/numbers/10.png'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number $number", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.deepPurple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Image.asset(
              numberImages[number]!,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              numberExamples[number]!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (index > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
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
                    child: Text("Previous", style: TextStyle(color: Colors.white)),
                  ),
                if (index < numbers.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
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
                    child: Text("Next", style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
