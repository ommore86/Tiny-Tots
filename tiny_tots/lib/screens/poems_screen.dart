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
      appBar: AppBar(
        title: Text("Poems for Kids"),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.pink.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: poems.length,
          itemBuilder: (context, index) {
            return _buildPoemCard(context, poems[index]);
          },
        ),
      ),
    );
  }

  Widget _buildPoemCard(BuildContext context, Map<String, String> poem) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      shadowColor: Colors.deepPurpleAccent,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              poem['title']!,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              poem['lyrics']!,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _playPoemAudio(poem['audio']!),
              icon: Icon(Icons.music_note),
              label: Text("Play Audio"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
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