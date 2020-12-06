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
    iCueCard(frontSide: 'comp', backSide: 'comp-CS'),
    iCueCard(frontSide: "1405", backSide: '1405-Python'),
    iCueCard(frontSide: '1406', backSide: '1406-JAVA'),
    iCueCard(frontSide: '2401', backSide: '2401-C'),
    iCueCard(frontSide: "2404", backSide: '2404-C++'),
    iCueCard(frontSide: '2406', backSide: '2406-Javascript'),
    iCueCard(frontSide: '3004', backSide: '3004-Dart/Flutter'),
    iCueCard(frontSide: "3000", backSide: '3000-pri'),
    iCueCard(frontSide: '3203', backSide: '3203-network'),
    iCueCard(frontSide: 'Math', backSide: 'Math-Calu'),
    iCueCard(frontSide: 'Earth', backSide: 'Earth-natural'),
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
        countdownTimer.cancel();
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
    /* if (cards.length <= 4 || _qnum > cards.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KahootStart()),
      );
    }*/
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
        ),
        body: Center(
          child: Column(children: [
            Container(width: 80.0, height: 10.0),
            new Text(
              '${cards[numberlist[index]].getBack()}',
              style: TextStyle(
                fontSize: 50,
                color: Colors.blue,
              ),
            ),
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
        ),
        body: Center(
          child: Column(children: [
            new Text(
              '${cards[numberlist[index]].getBack()}',
              style: TextStyle(
                fontSize: 50,
                color: Colors.blue,
              ),
            ),
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
