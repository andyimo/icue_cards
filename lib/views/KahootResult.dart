import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'KahootReview.dart';
import '../models/iCueCard.dart';
import 'Kahootstart.dart';
import '../screens/home/home.dart';

class KahootResult extends StatelessWidget {
  final String score;
  final List<iCueCard> wronglist;
  var strtime;
  KahootResult({this.score, this.wronglist, this.strtime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Kahoot Result"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home())),
          )
        ]),
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
                "$strtime",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 10,
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
                  fontSize: 20,
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
