import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PoemsScreen(),
  ));
}

class PoemsScreen extends StatelessWidget {
  final List<Map<String, String>> poems = [
    {
      'title': 'Twinkle Twinkle',
      'lyrics': '''Twinkle, twinkle, little star,  
How I wonder what you are!  
Up above the world so high,  
Like a diamond in the sky.''',
      'audio': 'assets/sounds/poems/twinkle.ogg',
    },
    {
      'title': 'Baa Baa Black Sheep',
      'lyrics': '''Baa, baa, black sheep,  
Have you any wool?  
Yes sir, yes sir,  
Three bags full.''',
      'audio': 'assets/sounds/poems/baa_baa_black_sheep.mp3',
    },
    {
      'title': 'Jack and Jill',
      'lyrics': '''Jack and Jill went up the hill  
To fetch a pail of water.  
Jack fell down and broke his crown,  
And Jill came tumbling after.''',
      'audio': 'assets/sounds/poems/jack_and_jill.mp3',
    },
    {
      'title': 'Humpty Dumpty',
      'lyrics': '''Humpty Dumpty sat on a wall,  
Humpty Dumpty had a great fall.  
All the king’s horses and all the king’s men,  
Couldn't put Humpty together again.''',
      'audio': 'assets/sounds/poems/humpty_dumpty.mp3',
    },
    {
      'title': 'Hickory Dickory Dock',
      'lyrics': '''Hickory, dickory, dock,  
The mouse ran up the clock.  
The clock struck one,  
The mouse ran down,  
Hickory, dickory, dock.''',
      'audio': 'assets/sounds/poems/hickory_dickory.mp3',
    },
    {
      'title': 'Mary Had a Little Lamb',
      'lyrics': '''Mary had a little lamb,  
Its fleece was white as snow.  
And everywhere that Mary went,  
The lamb was sure to go.''',
      'audio': 'assets/sounds/poems/mary_lamb.mp3',
    },
    {
      'title': 'Little Miss Muffet',
      'lyrics': '''Little Miss Muffet sat on a tuffet,  
Eating her curds and whey.  
Along came a spider,  
Who sat down beside her,  
And frightened Miss Muffet away!''',
      'audio': 'assets/sounds/poems/miss_muffet.mp3',
    },
    {
      'title': 'Hey Diddle Diddle',
      'lyrics': '''Hey diddle diddle, the cat and the fiddle,  
The cow jumped over the moon.  
The little dog laughed to see such fun,  
And the dish ran away with the spoon.''',
      'audio': 'assets/sounds/poems/hey_diddle.mp3',
    },
    {
      'title': 'One Two Buckle My Shoe',
      'lyrics': '''One, two, buckle my shoe.  
Three, four, shut the door.  
Five, six, pick up sticks.  
Seven, eight, lay them straight.  
Nine, ten, a big fat hen!''',
      'audio': 'assets/sounds/poems/one_two.mp3',
    },
    {
      'title': 'Rain Rain Go Away',
      'lyrics': '''Rain, rain, go away,  
Come again another day.  
Little children want to play,  
Rain, rain, go away.''',
      'audio': 'assets/sounds/poems/rain_rain.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Poems for Kids")),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: poems.length,
        itemBuilder: (context, index) {
          return _buildPoemCard(context, poems[index]);
        },
      ),
    );
  }

  Widget _buildPoemCard(BuildContext context, Map<String, String> poem) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              poem['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            SizedBox(height: 10),

            Text(
              poem['lyrics']!,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => _playPoemAudio(poem['audio']!),
              child: Text("🔊 Play Audio"),
            ),
          ],
        ),
      ),
    );
  }

  void _playPoemAudio(String audioPath) async {
    final player = AudioPlayer();
    await player.play(AssetSource(audioPath));
  }
}
