import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../models/iCueCard.dart';
import 'KahootResult.dart';
import 'Kahootstart.dart';
import 'dart:async';

class Kahoot extends StatefulWidget {
  final String category;
  final int questionNum;
  final int timer;
  final double mCurrentValue;
  Kahoot({this.category, this.questionNum, this.timer, this.mCurrentValue});

  @override
  _KahootState createState() => _KahootState(
      this.category, this.questionNum, this.timer, this.mCurrentValue);
}

class _KahootState extends State<Kahoot> {
  String _category;
  int _qnum;
  int _correctindex;
  int index = 0;
  int _grade = 0;
  List<iCueCard> _wronglist = [];
  int _timer = 1;
  double _mCurrentValue = 0.0;
  var str;
  Duration time;
  var seconds = 0;
  Timer countdownTimer;
  var _strtime = ' ';

  List<iCueCard> cards = [
    iCueCard(
        frontSide: "Cyclic Design Strategy",
        backSide:
            'Similar to Standard Design Strategy but can revert back to an earlier stage.'),
    iCueCard(
        frontSide: "Parallel Design Strategy",
        backSide: 'Independent alternatives are explored in parallel'),
    iCueCard(
        frontSide: 'Adaptive Design Stategy',
        backSide:
            'The next design strategy of the design activity is decided at the end of a given stage.'),
    iCueCard(
        frontSide: 'Incremental Design Strategy',
        backSide:
            'Each stage of development is treated as a task of incrementally improving the existing design'),
    iCueCard(
        frontSide: "Architectural Style",
        backSide:
            'Defines the components and connectors of a system (what?); not domain specific'),
    iCueCard(
        frontSide: 'Architectural Pattern',
        backSide:
            'Defines the implementation strategies of connectors and components in a system (how!); domain specific'),
    iCueCard(
        frontSide: 'Language-Based Style',
        backSide:
            'Architectural Style influenced by the programming language being used. e.g. Object-Oriented and Main-and-Subroutines'),
    iCueCard(
        frontSide: "Main Program and Subroutines Style",
        backSide:
            'Type of Language-Based Style. Components are (1) a main program, and (2) some subroutines. Connected together by function calls. Data is passed in/out of subroutines.'),
    iCueCard(
        frontSide: 'Object-oriented Style',
        backSide:
            'Type of Language-Based Style. Objects encapsulate state and accessing functions. State is strongly encapsulated. Not particularly efficient.'),
    iCueCard(
        frontSide: 'Layered Style',
        backSide:
            'Each layer exposes an API to be used by the layers above it. Each layer acts as a client (service consumer of the layer below) and a server (service provider to the layer above).'),
    iCueCard(
        frontSide: 'Strict Layering',
        backSide:
            'Type of Layered Architectural Style. A top layer can only use the resources/API of the layer directly below it.'),
    iCueCard(
        frontSide: 'Nonstrict Layering',
        backSide:
            'Type of Layered Architectural Style. A top layer can acccess the resources and API of any layer below it.'),
    iCueCard(
      frontSide: 'Virtual Machines',
      backSide:
          'Type of Layered Architectural Style. Ordered sequence of layers, each layer offering services to be used by programs residing in the layer(s) above it.',
    ),
    iCueCard(
      frontSide: 'Dataflow Style',
      backSide:
          'Architectural style with a focus on how data moves between processing elements',
    ),
    iCueCard(
      frontSide: 'Pipe and Filter',
      backSide:
          'Type of Dataflow Style. Separate programs are executed (potentially concurrently). Independent programs (components) are connected by pipes (routers of data streams) provided by the OS',
    ),
    iCueCard(
      frontSide: 'Interpreter Style',
      backSide:
          'Translates source code into an executable one instruction at a time. Parses and executes input commands, updating the state maintained by the interpreter.',
    ),
    iCueCard(
      frontSide: 'Software Architecture',
      backSide:
          'Set of principle design decisions governing a software system (structure, behaviour, interaction, non-functional properties)',
    ),
    iCueCard(
      frontSide: 'Prescriptive Architecture',
      backSide:
          'Dictates how the system will be build a priori (as-conceived/as-intended)',
    ),
    /*iCueCard(
      frontSide: 'Descriptive Architecture',
      backSide:
          'Describes how the system has actually been built (as-implemented/as-realized)',
    ),
    iCueCard(
      frontSide: 'Architectural Degradation',
      backSide:
          'Adding new design decisions to an architecture that deviate from the Prescriptive Architecture. e.g. Architectural Drift and Architectural Erosion',
    ),*/
  ];

  _KahootState(
      String cactegory, int questionNum, int timer, double mCurrentValue) {
    _category = cactegory;
    // ignore: unnecessary_statements
    _qnum = questionNum;
    _timer = timer;
    _mCurrentValue = mCurrentValue * 60;
    str = _mCurrentValue.toString();
    str = str.replaceFirst(".0", " ");
    seconds = int.parse(str);
    //seconds = 8;
    if (_timer == 1) {
      _counttime(seconds, _strtime);
    }
  }

  _counttime(int seconds, var strtime) {
    countdownTimer =
        new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
      if (seconds > 0) {
        seconds--;
        print(seconds);
      } else {
        countdownTimer.cancel();
        strtime = "End of time";
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KahootResult(
                    score: "$_grade / $_qnum",
                    wronglist: _wronglist,
                    strtime: strtime,
                  )),
        );
      }
    });
  }

  //this function is called when the player get the correct answer
  void _checkAnswer(int n, int nindex) {
    setState(() {
      if (_correctindex == n) {
        _grade++;
        print("You got right answer.");
      } else {
        print("You got wrong answer. ${cards[1]}");
        _wronglist.add(cards[nindex]);
        //print("You got wrong answer. ${cards[_index]}");
      }
      if (index == (_qnum - 1)) {
        if (_timer == 1) {
          countdownTimer.cancel();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KahootResult(
                    score: "$_grade / $index",
                    wronglist: _wronglist,
                    strtime: _strtime,
                  )),
        );
      }
      index++;
    });
  }

  List numberlist = [];
  @override
  Widget build(BuildContext context) {
    if (cards.length < 4 || _qnum > cards.length) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Kahoot Result"),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: new Column(
              children: <Widget>[
                Container(width: 80.0, height: 20.0),
                Text(
                  "Do not have enought card!",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Container(width: 80.0, height: 20.0),
                new RaisedButton(
                  child: Text(
                    'Go Back!',
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.blueAccent[600],
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KahootStart())),
                ),
              ],
            ),
          ));
    } else {
      if (index == 0) {
        for (int i = 0; i < cards.length; i++) {
          numberlist.add(i);
        }
        numberlist.shuffle();
      }

      int s1 = Random().nextInt(cards.length);
      int s2 = Random().nextInt(cards.length);
      int s3 = Random().nextInt(cards.length);
      while (cards[numberlist[index]] == cards[s1] ||
          cards[numberlist[index]] == cards[s2] ||
          cards[numberlist[index]] == cards[s3] ||
          s1 == s2 ||
          s2 == s3 ||
          s3 == s1) {
        s1 = Random().nextInt(cards.length);
        s2 = Random().nextInt(cards.length);
        s3 = Random().nextInt(cards.length);
      }
      _correctindex = Random().nextInt(4);
      List<String> ans = [
        cards[s1].getFront(),
        cards[s2].getFront(),
        cards[s3].getFront(),
      ];
      ans.insert(_correctindex, cards[numberlist[index]].getFront());

      if (_timer == 1) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Kahoot Game'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(children: [
              Container(width: 80.0, height: 15.0),
              new Text(
                '${cards[numberlist[index]].getBack()}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              Container(width: 80.0, height: 15.0),
              new RaisedButton(
                onPressed: () => _checkAnswer(0, numberlist[index]),
                child: new Text('${ans[0]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(1, numberlist[index]),
                child: new Text('${ans[1]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(2, numberlist[index]),
                child: new Text('${ans[2]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(3, numberlist[index]),
                child: new Text('${ans[3]}'),
              ),
            ]),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text('Kahoot Game'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Column(children: [
              Container(width: 80.0, height: 15.0),
              new Text(
                '${cards[numberlist[index]].getBack()}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              Container(width: 80.0, height: 15.0),
              new RaisedButton(
                onPressed: () => _checkAnswer(0, numberlist[index]),
                child: new Text('${ans[0]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(1, numberlist[index]),
                child: new Text('${ans[1]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(2, numberlist[index]),
                child: new Text('${ans[2]}'),
              ),
              new RaisedButton(
                onPressed: () => _checkAnswer(3, numberlist[index]),
                child: new Text('${ans[3]}'),
              ),
            ]),
          ),
        );
      }
    }
  }
}
