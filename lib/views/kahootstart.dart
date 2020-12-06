import 'package:flutter/material.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'Kahoot.dart';
//import 'dart:async';

class KahootStart extends StatefulWidget {
  @override
  _KahootStartState createState() => _KahootStartState();
}

class _KahootStartState extends State<KahootStart> {
  List<String> cards = ["Math", "Music", "English"];
  String _dropClassValue = "Math";
  int _dropNumValue = 5;
  int index = 0;
  int timer = 1;
  double mCurrentValue = 1.0;
  // AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kahoot Page'),
      ),
      body: Center(
        child: Column(children: [
          new DropdownButton(
              value: _dropClassValue,
              items: <String>["Math", "Music", "English"].map((String value) {
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
              items: <int>[5, 10].map((int value) {
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
        ]),
      ),
    );
  }
}
