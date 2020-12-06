import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'headsupstart.dart';
import 'HeadsUpResult.dart';
import '../models/iCueCard.dart';

class MistakesReview extends StatefulWidget {
  final List<iCueCard> list;
  MistakesReview({this.list});

  @override
  _MistakesReviewState createState() => _MistakesReviewState(list: this.list);
}

class _MistakesReviewState extends State<MistakesReview> {
  List<iCueCard> list;
  _MistakesReviewState({this.list});

  //GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int _index = 0;
  bool _isButtonDisabled1 = false; //go forward button
  bool _isButtonDisabled2 = false; //go backword button

  void _goforward() {
    setState(() {
      int len = list.length;
      print("The length is $len");
      if (_index == list.length - 1) {
        _isButtonDisabled1 = true;
      } else {
        _index++;
        _isButtonDisabled1 = false;
        _isButtonDisabled2 = false;
      }
    });
  }

  void _gobackward() {
    setState(() {
      if (_index == 0) {
        _isButtonDisabled2 = true;
      } else {
        _isButtonDisabled2 = false;
        _index--;
        _isButtonDisabled1 = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (list.length == 0) {
      return Scaffold(
        appBar: AppBar(title: Text("Congrates!")),
        body: Center(
          child: Text("You do everything right!"),
        ),
      );
    } else {
      iCueCard _current;
      _current = list[_index];
      int totallen = list.length;
      var _front = _current.getBack();
      var _back = _current.getFront();
      return Scaffold(
          appBar: AppBar(
            title: Text("Review the Mistakes"),
          ),
          body: new Container(
            padding: const EdgeInsets.only(top: 10),
            //height: ScreenUtil().setHeight(380), // 高度
            child: Swiper(
              scrollDirection: Axis.horizontal,
              itemCount: totallen,
              autoplay: false,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    //color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5),
                    color: list[index].getColor(),
                    child: FlipCard(
                      //key: cardKey,
                      //flipOnTouch: false,
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        child: Column(children: [
                          /*
                      new RaisedButton(
                        onPressed: () => cardKey.currentState.toggleCard(),
                      ),*/
                          Text(
                            list[index].getBack(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              //color:Colors.yellow,
                            ),
                          ),
                        ]),
                      ),
                      back: Container(
                        child: Text(
                          list[index].getFront(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            //color:Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
    }
  }
}
