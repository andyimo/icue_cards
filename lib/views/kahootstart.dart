import 'package:flutter/material.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'Kahoot.dart';

class KahootStart extends StatefulWidget {
  @override
  _KahootStartState createState() => _KahootStartState();
}

class _KahootStartState extends State<KahootStart> {
  List<String> cards = ["Math", "Music", "English"];
  String _dropClassValue = "Math";
  int _dropNumValue = 5;
  int index = 0;
  int _currentIndex = 0;
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
          new RaisedButton(
            child: Text('Start'),
            color: Colors.blueAccent[600],
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Kahoot(
                      category: _dropClassValue, questionNum: _dropNumValue)),
            ),
          ),
        ]),
      ),
    );
  }
}
