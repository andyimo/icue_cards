import 'package:flutter/material.dart';
import 'kahootstart.dart';
import 'package:icue_cards/views/headsupstart.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game Page'),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new RaisedButton(
                  child: Text('Heads Up!'),
                  color: Colors.blueAccent[600],
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HeadsUpStart())),
                ),
              ),
              new RaisedButton(
                child: Text('Kahoot!'),
                color: Colors.blueAccent[600],
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KahootStart())),
              ),
            ],
          ),
        ));
  }
}
