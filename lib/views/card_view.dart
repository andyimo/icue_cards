//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
//import '../tools/shuffle.dart';
import 'dart:async';

class CardView extends StatefulWidget {
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  StreamController<List<iCueCard>> _streamController;
  initState() {
    _streamController = StreamController<List<iCueCard>>();
    super.initState();
  }

  void _addToStream(List<iCueCard> cards, int index) {
    print(index);
    cards.add(cards[index]);
    cards.removeAt(index);
    _streamController.add(cards);
  }

  void _keepStream(List<iCueCard> cards, int index) {
    print(index);
    cards.removeAt(index);
    _streamController.add(cards);
  }

  void _refreshStream(List<iCueCard> oldCards, List<iCueCard> cards) {
    print(oldCards);
    print(cards);
    for (int i = cards.length - 1; i >= 0; i--) {
      cards.removeAt(i);
    }
    for (int i = 0; i < oldCards.length; i++) {
      cards.add(oldCards[i]);
    }
    _streamController.add(cards);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;
    List oldCards = rcvdData['list'];
    oldCards = oldCards.cast<iCueCard>();
    List<iCueCard> cards = new List();

    for (int i = 0; i < oldCards.length; i++) {
      cards.add(oldCards[i]);
    }

    //cards = shuffle(cards);
    String title = rcvdData['title'];
    cards = cards.cast<iCueCard>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue[600],
      ),
      body: StreamBuilder<List<iCueCard>>(
          stream: _streamController.stream,
          initialData: cards,
          builder: (BuildContext context, AsyncSnapshot<List<iCueCard>> cards) {
            //print('snapshot.data.length: ${cards.data.length}');
            if (cards.hasError) return Text('Error: ${cards.error}');
            print("build active");
            return _buildDeck(context, cards.data, oldCards);
          }),
    );
  }

  Widget _buildDeck(
      BuildContext context, List<iCueCard> cards, List<iCueCard> oldCards) {
    CardController controller;
    return Stack(
      key: UniqueKey(),
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Container(
          key: UniqueKey(),
          color: Colors.grey[200],
          child: TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.TOP,
            totalNum: cards.length,
            stackNum: 4,
            swipeEdge: 3.0,
            maxWidth: MediaQuery.of(context).size.width * 0.86,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minWidth: MediaQuery.of(context).size.width * 0.85,
            minHeight: MediaQuery.of(context).size.height * 0.785,
            cardBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlipCard(
                key: UniqueKey(),
                direction: FlipDirection.HORIZONTAL,
                speed: 1000,
                front: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(0.5, 0.5), // shadow direction: bottom right
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/background.png',
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          cards[index].getFront(),
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                back: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              0.5, 0.5), // shadow direction: bottom right
                        )
                      ],
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/background.png',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          cards[index].getBack(),
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (orientation == CardSwipeOrientation.LEFT) {
                _addToStream(cards, index);
              } else if (orientation == CardSwipeOrientation.RIGHT ||
                  orientation == CardSwipeOrientation.UP ||
                  orientation == CardSwipeOrientation.DOWN) {
                _keepStream(cards, index);
              }

              /// Get orientation & index of swiped card!
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.replay),
              onPressed: () {
                _refreshStream(oldCards, cards);
              }),
        ),
      ],
    );
  }
}
