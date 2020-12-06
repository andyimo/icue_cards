import 'package:flutter/material.dart';
import 'package:icue_cards/screens/home/home.dart';
import 'headsupstart.dart';
import 'Kahootstart.dart';

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
  GamePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
              child: Text('Heads Up Game'),
              color: Colors.blueAccent[600],
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HeadsUpStart())),
            ),
            new RaisedButton(
              child: Text('Kahoot Game'),
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
