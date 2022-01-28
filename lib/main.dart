import 'package:emotion_detection_twitter/chart.dart';
import 'package:emotion_detection_twitter/networking.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showContainer = false;
  var userName;
  List<int> emotionsCount = [];
  int joyCount = 0, angerCount = 0,neutralCount = 0, sadnessCount = 0, fearCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Emotion Detection Twitter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Twitter Username',
              ),
              onChanged: (text) {
                userName = text;
                print(userName);
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Search'),
            onPressed: () async{
              setState(() {
                if(showContainer) showContainer = false;
                joyCount=0;
                angerCount=0;
                sadnessCount =0;
                neutralCount =0;
                fearCount = 0;
              });
              var tweets = await getTweets(userName);
              // for(int i = 0 ; i < tweets.length ; i++)
              // print(tweets[i]);
              for(int i = 0; i < tweets.length ; i++) {
                if (tweets[i] == 'joy')
                  joyCount++;
                if (tweets[i] == 'anger')
                  angerCount++;
                if (tweets[i] == 'sadness')
                  sadnessCount++;
                if (tweets[i] == 'neutral')
                  neutralCount++;
                if (tweets[i] == 'fear')
                  fearCount++;
              }
            //  emotionsCount = [joyCount,angerCount,sadnessCount,neutralCount,fearCount];
              setState(() {
                showContainer = true;
              });
            },
          ),
          SizedBox(height: 10),
          if(showContainer && joyCount+angerCount+neutralCount
          +sadnessCount+fearCount == 0) Text('No tweets available',style: TextStyle(fontSize: 22),),
          if(showContainer && joyCount+angerCount+neutralCount
              +sadnessCount+fearCount != 0)
            PieChartSample2(joyCount, angerCount,neutralCount , sadnessCount, fearCount),
        ],
      ),
    );
  }
}

// List<int> getEmotionsCount(var tweets) {
//   int joyCount = 0, angerCount = 0,neutralCount = 0, sadnessCount = 0, fearCount = 0;
//   for(int i = 0; i < tweets.length ; i++) {
//     if (tweets[i] == 'joy')
//       joyCount++;
//     if (tweets[i] == 'anger')
//       angerCount++;
//     if (tweets[i] == 'sadness')
//       sadnessCount++;
//     if (tweets[i] == 'neutral')
//       neutralCount++;
//     if (tweets[i] == 'fear')
//       fearCount++;
//   }
//   List<int> emotionsCount = [joyCount,angerCount,sadnessCount,neutralCount,fearCount];
//   return emotionsCount;
// }