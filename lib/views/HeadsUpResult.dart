import '../models/iCueCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MistakesReview.dart';
import 'headsupstart.dart';

class HeadsUpResult extends StatefulWidget {
  final int score;
  final List<iCueCard> mislst;
  HeadsUpResult({this.score, this.mislst});

  @override
  _HeadsUpResultState createState() =>
      _HeadsUpResultState(score: this.score, mislst: this.mislst);
}

class _HeadsUpResultState extends State<HeadsUpResult> {
  final int score;
  final List<iCueCard> mislst;
  _HeadsUpResultState({this.score, this.mislst});

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
      appBar:
          AppBar(automaticallyImplyLeading: false, title: Text("Game Result")),
      body: Center(
        child: Column(
          children: [
            Text(
              'The final score is ',
            ),
            Text("$score"),
            new RaisedButton(
              //for the replay the game
              child: Text('Play it Again'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HeadsUpStart()),
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
