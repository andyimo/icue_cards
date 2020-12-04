import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:get/get.dart';
import '../models/deck.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Lists extends StatefulWidget {
  final Deck deck;
  Lists({this.deck});
  @override
  _ListState createState() => _ListState(this.deck);
}

class _ListState extends State<Lists> {
  String curSelection = "Date";
  MultiSelectController controller = new MultiSelectController();
  Deck deck;
  _ListState(Deck deck) {
    this.deck = deck;
  }
  @override
  void initState() {
    super.initState();
    controller.set(deck.getLength());
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }

  void delete() {
    if (controller.selectedIndexes.length == 0) {
      Get.snackbar("Select something to delete.", "or not.");
      return;
    }
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are You Sure?",
      desc: "Delete Selected Cards",
      buttons: [
        DialogButton(
            child: Text(
              "Maybe Not",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.purple[900]),
        DialogButton(
          child: Text(
            "Sure!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            var list = controller.selectedIndexes;
            list.sort((b, a) =>
                a.compareTo(b)); //reoder from biggest number, so it wont error
            list.forEach((element) {
              deck.removeCard(element);
            });

            setState(() {
              controller.set(deck.getLength());
            });
          },
          color: Colors.red[800],
        )
      ],
    ).show();
  }

  void combine() {
    var list = controller.selectedIndexes;
    if (list.length == 0) {
      Get.snackbar('I know you can do better than this', 'Select Something');
      return;
    }
    List<iCueCard> temp = new List();
    for (int i = 0; i < list.length; i++) {
      temp.add(deck.getCards()[list[i]]);
    }
    Navigator.pushNamed(context, "/cardView",
        arguments: {"list": temp, "title": deck.getName()});
  }

  @override
  Widget build(BuildContext context) {
    final title = deck.getName();
    void newCard() async {
      dynamic result = await Navigator.pushNamed(context, '/newCard');
      if (result != null) {
        newCard();
        print(result);
        setState(() {
          print(result);
          deck.addCard(iCueCard(
            frontSide: result['frontside'],
            backSide: result['backside'],
            color: result['color'],
            image: result['image'] == null ? null : result['image'],
          ));
          Get.snackbar(result['frontside'], 'Added');
        });
      }
    }

    void editCard(iCueCard item) async {
      dynamic result = await Navigator.pushNamed(context, '/newCard',
          arguments: {"card": item});

      if (result != null) {
        setState(() {
          item.setFront(result['frontside']);
          item.setBack(result['backside']);
          item.setColor(result['color']);
          item.setImage(result['image'] == null ? null : result['image']);
          Get.snackbar(result['frontside'], 'Edited');
        });
      }
    }

    return Scaffold(
        // the main view
        floatingActionButton: (title == "Combined")
            ? null
            : FloatingActionButton(
                backgroundColor: Colors.blue[700],
                child: Icon(Icons.add),
                onPressed: () {
                  newCard();
                }),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(title),
          actions: (controller.isSelecting)
              ? [
                  IconButton(
                    icon: Icon(Icons.select_all),
                    onPressed: selectAll,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: delete,
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: combine,
                  ),
                ]
              : [
                  dropdownWidget(deck),
                  IconButton(
                    icon: Icon(Icons.grading),
                    onPressed: () {
                      setState(() {
                        controller.isSelecting = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/cardView",
                          arguments: {"list": deck.getCards(), "title": title});
                    },
                  ),
                ],
          backgroundColor: Colors.blue[700],
        ),
        body: Container(
          color: Colors.grey[200],
          child: DragAndDropList(
            deck.getCards(),
            itemBuilder: (context, item) {
              String tempId = item.getId();
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Slidable(
                  key: Key(item.getId()),
                  dismissal: SlidableDismissal(
                    dismissThresholds: <SlideActionType, double>{
                      SlideActionType.primary: 1.0
                    },
                    child: SlidableDrawerDismissal(),
                    onDismissed: (actionType) {
                      setState(() {
                        deck
                            .getCards()
                            .removeWhere((item) => item.getId() == tempId);
                      });
                    },
                  ),
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: listContainer(item.getFront(), item.getBack(),
                      item.getColor(), deck.getCards().indexOf(item)),
                  actions: [
                    IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () {
                          editCard(item);
                        }),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => {
                              setState(() {
                                deck.removeCard(deck.getCards().indexOf(item));
                                //.removeWhere((item) => item.getId() == tempId);
                              })
                            }),
                  ],
                ),
              );
            },
            onDragFinish: (before, after) {
              deck.insertCard(after, deck.removeCard(before));
            },
            canBeDraggedTo: (one, two) => true,
            dragElevation: 8.0,
          ),
        ));
  }

  Widget dropdownWidget(Deck deck) {
    final List<String> _dropdownValues = [
      "Name",
      "Date",
    ]; //The li
    return DropdownButton(
      dropdownColor: Colors.blue[700],
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      value: curSelection,
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (String value) {
        //once dropdown changes, update the state of out currentValue
        setState(() {
          curSelection = value;
          if (value == "Date") {
            deck.sortByTime();
          } else {
            deck.sortByName();
          }
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
    );
  }

  Widget listContainer(String front, String back, Color cardColor, int index) {
    return Container(
        height: 110,
        child: InkWell(
          onTap: () {
            if (controller.isSelecting) {
              setState(() {
                controller.toggle(index);
              });
            }
          },
          child: Material(
              color: controller.isSelected(index) ? Colors.grey : Colors.white,
              shadowColor: Colors.grey,
              elevation: 20,
              child: Row(
                children: [
                  Container(
                    //color line
                    height: 120,
                    width: 10,
                    color: cardColor,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 29,
                        child: Text(
                          front,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        color: cardColor,
                        thickness: 2,
                      ),
                      Container(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(back,
                              textAlign: TextAlign.center,
                              style: (TextStyle(fontSize: 22))),
                        ),
                      ),
                    ],
                  ))
                ],
              )),
        ));
  }
}
