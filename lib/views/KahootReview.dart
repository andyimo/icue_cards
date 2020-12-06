import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'Kahootstart.dart';
import 'KahootResult.dart';

class Review extends StatefulWidget {
  final List<iCueCard> wronglist;

  //var strtime;
  Review({this.wronglist});
  @override
  _ReviewState createState() => _ReviewState(this.wronglist);
}

class _ReviewState extends State<Review> {
  List<iCueCard> _wronglist;

  //var _strtime;
  _ReviewState(List<iCueCard> wronglist) {
    _wronglist = wronglist;

    //_strtime = strtime;
  }
  int index = 0;

  @override
  Widget build(BuildContext context) {
    //print(_wronglist.length);
    if (_wronglist.length == 0) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
            "Review",
          )),
          body: Center(
            child: Column(children: [
              Text(
                "   ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              new Text(
                "Nothing to review!",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
              Text(
                "   ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Back to Start page!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KahootStart())),
              ),
            ]),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Review"),
        ),
        body: ConstrainedBox(
          //ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
            children: <Widget>[
              Container(
                //color: Colors.blue,
                height: 430,
                width: 270,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${_wronglist[index].getFront()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    Container(width: 80.0, height: 15.0),
                    Divider(
                      height: 2.0,
                      color: Colors.grey[700],
                    ),
                    Container(width: 80.0, height: 15.0),
                    Text(
                      '${_wronglist[index].getBack()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30.0,
                child: Row(children: <Widget>[
                  RaisedButton(
                    child: Text('Prev'),
                    onPressed: () {
                      setState(() {
                        if (index > 0) {
                          index--;
                        }
                      });
                    },
                  ),
                  Container(width: 10.0, height: 1.0),
                  RaisedButton(
                    child: Text('Back to Result page!'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KahootResult())),
                  ),
                  Container(width: 10.0, height: 1.0),
                  RaisedButton(
                    child: Text('Next'),
                    onPressed: () {
                      setState(() {
                        if (index < _wronglist.length - 1) {
                          index++;
                        }
                      });
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
    }
  }
}

