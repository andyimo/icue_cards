/* The card list screen
   [List all the cards in a deck]
   Author: Henry Tu
*/
import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:get/get.dart';
import '../models/deck.dart';
import '../models/folder.dart';
import '../models/root.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:nice_button/nice_button.dart';

class Lists extends StatefulWidget {
  final Deck deck;
  final Root root;
  Lists({this.deck, this.root});
  @override
  _ListState createState() => _ListState(this.deck, this.root);
}

class _ListState extends State<Lists> {
  String curSelection = "Date";
  MultiSelectController controller = new MultiSelectController();
  Deck deck;
  Root root;
  String title;
  var selectedFolder;
  var selectedDeck;
  var selectedFolderName;
  var selectedDeckName;
  List<String> decks = [];
  _ListState(Deck deck, Root root) {
    this.deck = deck;
    this.root = root;
    this.title = deck.getName();
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

  void delete(List indexes) {
    if (indexes.length == 0) {
      Get.snackbar("Select something", "or not.");
      return;
    }
    setState(() {
      var list = indexes;
      list.sort((b, a) =>
          a.compareTo(b)); //reoder from biggest number, so it wont error
      list.forEach((element) {
        deck.removeCard(element);
      });
    });
  }

  void addToRecentlyDeleted(List indexes) {
    if (title == "Recently Deleted") {
      return;
    }
    indexes.forEach((element) {
      if (title != "Recently Deleted") {
        root.addDeleted(deck.getCards()[element]);
      }
    });
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
    void newCard() async {
      dynamic result = await Navigator.pushNamed(context, '/newCard');
      if (result != null) {
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
        floatingActionButton: controller.isSelecting == true
            ? FloatingActionButton(
                backgroundColor: Colors.blue[600],
                child: title != "Recently Deleted"
                    ? Icon(Icons.merge_type)
                    : Icon(Icons.restore),
                onPressed: () {
                  if (controller.selectedIndexes.length == 0) {
                    Get.snackbar("Select Something", "or not");
                    return;
                  }
                  _showDialog(context);
                })
            : (title == "Combined" || title == "Recently Deleted")
                ? null
                : FloatingActionButton(
                    backgroundColor: Colors.blue[600],
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
                    onPressed: () {
                      List addList = new List();
                      addList.addAll(controller.selectedIndexes);
                      addToRecentlyDeleted(addList);
                      delete(addList);
                      setState(() {
                        controller.set(deck.getLength());
                      });
                    },
                  ),
                  title != "Recently Deleted"
                      ? IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: combine,
                        )
                      : Text(""),
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
                  title != "Recently Deleted"
                      ? IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/cardView",
                                arguments: {
                                  "list": deck.getCards(),
                                  "title": title
                                });
                          },
                        )
                      : Text(""),
                ],
          backgroundColor: Colors.blue[600],
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
                        if (title != "Recently Deleted") {
                          root.addDeleted(item);
                        }
                        controller.set(deck.getLength());
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
                        color: Colors.blue[600],
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
                                if (title != "Recently Deleted") {
                                  root.addDeleted(item);
                                }
                                controller.set(deck.getLength());
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
      dropdownColor: Colors.blue[600],
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
        height: 100,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2.5, 17.5, 0, 2.5),
                          child: Text(
                            front,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: cardColor,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                          child: Text(back,
                              textAlign: TextAlign.center,
                              style: (TextStyle(fontSize: 19, height: 1.75))),
                        ),
                      ),
                    ],
                  ))
                ],
              )),
        ));
  }

  Future _showDialog(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                DropdownButton<String>(
                  onChanged: (String value) {
                    setState(() {
                      selectedFolderName = value;
                      selectedFolder = root
                          .getFolders()[root.getFolderNames().indexOf(value)];
                      decks = selectedFolder.getDeckNames();
                      selectedDeckName = null;
                    });
                  },
                  hint: Text('Choose a Folder'),
                  value: selectedFolderName,
                  items: root.getFolderNames().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                DropdownButton<String>(
                  onChanged: (String value) {
                    setState(() {
                      selectedDeckName = value;
                    });
                  },
                  hint: new Text('Choose a Deck'),
                  value: selectedDeckName,
                  items: decks.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),
                NiceButton(
                  width: 100,
                  elevation: 8.0,
                  radius: 52.0,
                  text: "Add",
                  background: Colors.blue,
                  onPressed: () {
                    setState(() {
                      selectedDeck = selectedFolder.getDecks()[selectedFolder
                          .getDeckNames()
                          .indexOf(selectedDeckName)];

                      for (int i = 0;
                          i < controller.selectedIndexes.length;
                          i++) {
                        selectedDeck.addCard(
                            deck.getCards()[controller.selectedIndexes[i]]);
                      }

                      delete(controller.selectedIndexes);

                      controller.set(deck.getLength());

                      print("in showdiag");
                      Navigator.pop(context);
                    });
                  },
                ),
              ]);
            },
          ),
        );
      },
    );
  }
}
