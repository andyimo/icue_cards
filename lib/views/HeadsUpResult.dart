import 'package:icue_cards/screens/home/home.dart';

import '../models/iCueCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MistakesReview.dart';
import '../models/root.dart';

class HeadsUpResult extends StatefulWidget {
  final Root root;
  final int score;
  final List<iCueCard> mislst;
  HeadsUpResult({this.root, this.score, this.mislst});

  @override
  _HeadsUpResultState createState() => _HeadsUpResultState(
      root: this.root, score: this.score, mislst: this.mislst);
}

class _HeadsUpResultState extends State<HeadsUpResult> {
  final Root root;
  final int score;
  final List<iCueCard> mislst;
  _HeadsUpResultState({this.root, this.score, this.mislst});

  @override
  void initState() {
    super.initState();
    // vertical view
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Game Result"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Icon(
                Icons.home,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'The final score is',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50.0,
                  //color:Colors.yellow,
                ),
              ),
            ),
            Text(
              "$score",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 80.0,
                //color:Colors.yellow,
              ),
            ),
            new RaisedButton(
              //for the replay the game
              child: Text('Play it Again'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HeadsUpStart(root: root)),
              ),
            ),
            new RaisedButton(
              //for review the mistakes
              child: Text('Review the Unsuccess Guess'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MistakesReview(list: mislst)),
              ),
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
