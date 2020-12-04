import '../models/iCueCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'KahootResult.dart';

class Kahoot extends StatefulWidget {
  final String category;
  final int questionNum;
  Kahoot({this.category, this.questionNum});

  @override
  _KahootState createState() => _KahootState(this.category, this.questionNum);
}

class _KahootState extends State<Kahoot> {
  String _category;
  int _qnum;
  int _correctindex;
  int index = 0;
  int _grade = 0;
  List<iCueCard> _wronglist = [];

  _KahootState(String cactegory, int questionNum) {
    _category = cactegory;
    // ignore: unnecessary_statements
    _qnum = questionNum;
  }

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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KahootResult(
                  score: "$_grade / $index", wronglist: _wronglist)),
        );
      }
      index++;
    });
  }

  List numberlist = [];
  @override
  Widget build(BuildContext context) {
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
