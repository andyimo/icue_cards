import 'package:flutter/material.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'Kahoot.dart';
import 'dart:async';

//import 'root.dart';

// ignore: must_be_immutable
class KahootStart extends StatefulWidget {
  //String str;
  //final Root root;
  //KahootStart({this.root, this.str});
  @override
  _KahootStartState createState() =>
      _KahootStartState(/*root: this.root, str: this.str*/);
}

class _KahootStartState extends State<KahootStart> {
  List<String> cards = ["CompSci", "Math", "Physics", "English"];
  String _dropClassValue = "CompSci";
  int _dropNumValue = 5;
  int index = 0;
  int timer = 1;
  double mCurrentValue = 1.0;
  String str;
  //final Root root;

  //_KahootStartState({this.root, this.str});

  @override
  Widget build(BuildContext context) {
    if (str == null) {
      str = '';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kahoot Page'),
      ),
      body: Center(
        child: Column(children: [
          new DropdownButton(
              value: _dropClassValue,
              items: <String>["CompSci", "Math", "Physics", "English"]
                  .map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _dropClassValue = value;
                });
              }),
          new DropdownButton(
              value: _dropNumValue,
              items: <int>[5, 10, 15, 20].map((int value) {
                return new DropdownMenuItem(
                  value: value,
                  child: Text("$value"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _dropNumValue = value;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Countdown： Yes"),
              Radio(
                value: 1,
                groupValue: this.timer,
                onChanged: (value) {
                  setState(() {
                    this.timer = value;
                  });
                },
              ),
              SizedBox(width: 20),
              Text("No："),
              Radio(
                value: 2,
                groupValue: this.timer,
                onChanged: (value) {
                  setState(() {
                    this.timer = value;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Minutes:"),
              Slider(
                  value: mCurrentValue,
                  min: 1,
                  max: 10,
                  label: '$mCurrentValue',
                  divisions: 10,
                  onChanged: (e) {
                    setState(() {
                      //四舍五入的双精度值
                      mCurrentValue = e.roundToDouble();
                    });
                  }),
            ],
          ),
          new RaisedButton(
            child: Text('Start'),
            color: Colors.blueAccent[600],
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Kahoot(
                      category: _dropClassValue,
                      questionNum: _dropNumValue,
                      timer: timer,
                      mCurrentValue: mCurrentValue)),
            ),
          ),
          Text(
            '',
            style: TextStyle(
              fontSize: 10,
              color: Colors.blue,
            ),
          ),
          Text(
            '$str',
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
        ]),
      ),
    );
  }
}
