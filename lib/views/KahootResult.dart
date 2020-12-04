import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Review.dart';
import '../models/iCueCard.dart';
import 'kahootstart.dart';

class KahootResult extends StatelessWidget {
  final String score;
  final List<iCueCard> wronglist;
  KahootResult({this.score, this.wronglist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Kahoot")),
        body: Center(
          child: new Column(
            children: <Widget>[
              Text(
                "   ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "Your grade is $score !",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
              Text(
                "   ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              new RaisedButton(
                child: Text('Back to Start page!'),
                color: Colors.blueAccent[600],
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KahootStart())),
              ),
              new RaisedButton(
                child: Text('Review Wrong Question!'),
                color: Colors.blueAccent[600],
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Review(wronglist: wronglist))),
              ),
            ],
          ),
        ));
  }
}
