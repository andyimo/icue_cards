import 'package:flutter/material.dart';
import 'package:icue_cards/tools/shuffle.dart';
import '../models/iCueCard.dart';
import '../models/folder.dart';
import '../models/deck.dart';
import './card_list.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

class DirectoryDeck extends StatefulWidget {
  final Folder folder;
  DirectoryDeck({this.folder});
  @override
  _DirectoryDeckState createState() => _DirectoryDeckState(this.folder);
}

class _DirectoryDeckState extends State<DirectoryDeck> {
  MultiSelectController controller = new MultiSelectController();
  Folder folder;
  _DirectoryDeckState(Folder folder) {
    this.folder = folder;
  }

  @override
  void initState() {
    controller.set(folder.getLength());

    super.initState();
  }

  void _showDialog() {
    String dialogText;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deck Name:"),
          content: TextField(
            onChanged: (String textTyped) {
              setState(() {
                dialogText = textTyped;
              });
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: ''),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        if (dialogText == null) {
                          return;
                        }
                        Deck temp = new Deck(dialogText);
                        folder.addDeck(temp);
                        controller.set(folder.getLength());
                      });
                      Navigator.of(context).pop();
                    },
                    child: new Text("Save"))
              ],
            ),
          ],
        );
      },
    );
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
      desc: "Delete All Cards in these decks",
      buttons: [
        DialogButton(
            child: Text(
              "Maybe Not",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo),
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
              folder.removeDeck(element);
            });

            setState(() {
              controller.set(folder.getLength());
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
    if (list.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Lists(
                  deck: folder.getDecks()[list[0]],
                )),
      );
      setState(() {
        controller.deselectAll();
      });
      return;
    }

    Deck newDeck = new Deck("Combined");
    List<iCueCard> newList = new List();
    list.forEach((element) {
      newList = newList + folder.getDecks()[element].getCards();
    });
    newList = shuffle(newList);
    newDeck.setList(newList);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Lists(
                deck: newDeck,
              )),
    );
    setState(() {
      controller.deselectAll();
    });
  }

  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Deck row = folder.removeDeck(oldIndex);
        folder.insertDeck(newIndex, row);
      });
    }

    List<Container> tempList = new List();
    for (int index = 0; index < folder.getLength(); index++) {
      tempList.add(Container(
        height: 120,
        width: 100,
        decoration: BoxDecoration(
          color: controller.isSelected(index) ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0.75, 0.5), // shadow direction: bottom right
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            if (controller.isSelecting) {
              setState(() {
                controller.toggle(index);
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Lists(
                          deck: folder.getDecks()[index],
                        )),
              );
            }
          },
          onDoubleTap: () {
            if (controller.isSelecting) {
              return;
            } else {
              Navigator.pushNamed(context, "/cardView", arguments: {
                "list": folder.getDecks()[index].getCards(),
                "title": folder.getDecks()[index].getName()
              });
            }
          },
          child: Center(
            child: Text(
              folder.getDecks()[index].getName(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    }

    var gridView = Center(
      child: ReorderableWrap(
        spacing: 20,
        runSpacing: 20,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        children: tempList,
        onReorder: _onReorder,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.add),
          onPressed: () {
            _showDialog();
          }),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(folder.getName()),
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
                  onPressed: (combine),
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.grading),
                  onPressed: () {
                    setState(() {
                      controller.isSelecting = true;
                    });
                  },
                ),
              ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: gridView,
        ),
      ),
    );
  }
}
