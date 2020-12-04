import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HeadsUpResult.dart';
import '../models/iCueCard.dart';

class HeadsUp extends StatefulWidget {
  final String category;
  final String questionNum;
  //final int ori;
  HeadsUp({this.category, this.questionNum});

  @override
  _HeadsUpState createState() => _HeadsUpState();
}

class _HeadsUpState extends State<HeadsUp> {
  int _score = 0;

  //List<String> cards = ["user case", "windows", "linux", "user story", "POSIX", "filesystem"]; //in the future, this will read from database, just for testing
  List<iCueCard> cards = [
    iCueCard(frontSide: 'who is the NBA G.O.A.T. ?', backSide: 'LeBron James'),
    iCueCard(
        frontSide:
            "What is the last name of Jackie Chan's character in Rush Hour?",
        backSide: 'Lee'),
    iCueCard(frontSide: 'sample question', backSide: 'sample answer')
  ];
  List<iCueCard> mistakes = [];
  int index = 0;
  bool isOver = false; //the boolen value which states if the game is over

  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
    ///强制竖屏
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
  }*/
  @override
  void initState() {
    super.initState();
    // horizontal view
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  /*
  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
 
    if (widget.ori == 1) {

      OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
    } else {

      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }*/

  //this function is called when the player get the correct answer
  void _correctAnswer() {
    setState(() {
      _score++;
      //index++;
      int length = cards.length; //check point is at length-1
      print("length is $length");
      if (index == 2) {
        isOver = true;
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  HeadsUpResult(score: _score, mislst: mistakes)),
        );
      }
      index++;
    });
  }

  //this function is called when the player get the wrong answer

  void _wrongAnswer() {
    setState(() {
      mistakes.add(cards[index]);
      //index++;
      int length = cards.length; //check point is at length-1
      if (index == 2) {
        //determine if the game is over
        isOver = true;
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  HeadsUpResult(score: _score, mislst: mistakes)),
        );
      }
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index >= 3) {
      //this if means checking when the index is out of range, reset into the range
      index = 0;
    }
    var _keyword;
    _keyword = cards[index].getBack();
    return new Scaffold(
      appBar: new AppBar(
          automaticallyImplyLeading: false, title: new Text("Heads Up Game")),
      body: Center(
        child: Center(
            child: Text(
          "$_keyword",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            //color:Colors.yellow,
          ),
        )),
      ),
      floatingActionButton: Row(
        //two botton for count correct/wrong Answer
        children: [
          FloatingActionButton(
            child: Icon(Icons.done),
            tooltip: 'correct answer',
            onPressed: _correctAnswer,
            heroTag: "first",
          ),
          FloatingActionButton(
            child: Icon(Icons.clear),
            tooltip: 'wrong answer',
            onPressed: _wrongAnswer,
            heroTag: "second",
          ),
        ],
      ),
    );
    // TODO: implement build
    //please add the navigation on main page, do not need to edit the code above
    //throw UnimplementedError();
  }
}
