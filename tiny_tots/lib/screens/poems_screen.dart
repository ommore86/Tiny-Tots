import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: PoemsScreen()));
}

class PoemsScreen extends StatelessWidget {
  final List<Map<String, String>> poems = [
    {
      'title': 'Twinkle Twinkle',
      'lyrics':
          '''Twinkle, twinkle, little star,\nHow I wonder what you are!\nUp above the world so high,\nLike a diamond in the sky.''',
      'videoId': 'yCjJyiqpAuU',
    },
    {
      'title': 'Baa Baa Black Sheep',
      'lyrics':
          '''Baa, baa, black sheep,\nHave you any wool?\nYes sir, yes sir,\nThree bags full.''',
      'videoId': 'MR5XSOdjKMA',
    },
    {
      'title': 'Jack and Jill',
      'lyrics':
          '''Jack and Jill went up the hill\nTo fetch a pail of water.\nJack fell down and broke his crown,\nAnd Jill came tumbling after.''',
      'videoId': 'RbNQ0SQT0Z4',
    },
    {
      'title': 'Humpty Dumpty',
      'lyrics': 
        '''Humpty Dumpty sat on a wall, \nHumpty Dumpty had a great fall. \nAll the king’s horses and all the king’s men, \nCouldn't put Humpty together again.''',
      'videoId': 'nrv495corBc',
    },
    {
      'title': 'Hickory Dickory Dock',
      'lyrics': 
        '''Hickory, dickory, dock, \nThe mouse ran up the clock. \nThe clock struck one, \nThe mouse ran down, \nHickory, dickory, dock.''',
      'videoId': 'ygcN65SlLFg',
    },
    {
      'title': 'Mary Had a Little Lamb',
      'lyrics': 
        '''Mary had a little lamb, \nIts fleece was white as snow. \nAnd everywhere that Mary went, \nThe lamb was sure to go.''',
      'videoId': 'aTrtKikAW6E',
    },
    {
      'title': 'Little Miss Muffet',
      'lyrics':
        '''Little Miss Muffet sat on a tuffet, \nEating her curds and whey. \nAlong came a spider, \nWho sat down beside her, \nAnd frightened Miss Muffet away!''',
      'videoId': 'RPWvweIp6hM',
    },
    {
      'title': 'Hey Diddle Diddle',
      'lyrics': 
        '''Hey diddle diddle, the cat and the fiddle, \nThe cow jumped over the moon. \nThe little dog laughed to see such fun, \nAnd the dish ran away with the spoon.''',
      'videoId': 'E437dFS63xg',
    },
    {
      'title': 'One Two Buckle My Shoe',
      'lyrics':
        '''One, two, buckle my shoe. \nThree, four, shut the door. \nFive, six, pick up sticks. \nSeven, eight, lay them straight. \nNine, ten, a big fat hen!''',
      'videoId': 'ARiHneKb_U0',
    },
    {
      'title': 'Rain Rain Go Away',
      'lyrics':
        '''Rain, rain, go away, \nCome again another day. \nLittle children want to play, \nRain, rain, go away.''',
      'videoId': 'SrDTSB5bVS4',
    },
    // Add more poems and YouTube videoIds here
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
      body: ListView.builder(
        itemCount: poems.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final poem = poems[index];
          return _buildPoemCard(context, poem);
        },
      ),
    );
  }

  Widget _buildPoemCard(BuildContext context, Map<String, String> poem) {
    final String videoId = poem['videoId']!;
    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      shadowColor: Colors.deepPurpleAccent,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              poem['title']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              poem['lyrics']!,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.deepPurple,
                handleColor: Colors.purpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
