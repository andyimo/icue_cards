import 'package:flutter/material.dart';
import 'package:icue_cards/screens/home/home.dart';
import 'headsupstart.dart';
import 'Kahootstart.dart';
import '../models/root.dart';

/*void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(title: 'Game Page'),
    );
  }
}*/

class GamePage extends StatefulWidget {
  final Root root;
  GamePage({this.root});

  @override
  _GamePageState createState() => _GamePageState(root: this.root);
}

class _GamePageState extends State<GamePage> {
  final Root root;
  _GamePageState({this.root});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Page"), actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())),
        )
      ]),
      body: Center(
        child: new Column(
          children: <Widget>[
            Container(width: 80.0, height: 20.0),
            new RaisedButton(
              child: Text('Heads Up!'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HeadsUpStart(root: root))),
            ),
            new RaisedButton(
              child: Text('Kahoot!'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KahootStart())),
            ),
          ],
        ),
      ),
    );
  }
}
