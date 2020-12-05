/* The root screen
   [List all the folders in root]
   Author: Henry Tu
*/

import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import '../models/folder.dart';
import '../models/deck.dart';
import '../models/root.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';
import './search.dart';
import 'package:reorderables/reorderables.dart';
import './dir_folder.dart';
import './card_list.dart';

class MainDirectory extends StatefulWidget {
  final Root root;
  MainDirectory({this.root});
  @override
  _MainDirectoryState createState() => _MainDirectoryState(this.root);
}

class _MainDirectoryState extends State<MainDirectory> {
  Root root;
  _MainDirectoryState(Root root) {
    this.root = root;
  }

  MultiSelectController controller = new MultiSelectController();
  List folders = new List();

  @override
  void initState() {
    super.initState();
    controller.set(folders.length);
    folders = root.getFolders();
  }

  void _showDialog() {
    String dialogText;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Folder Name:"),
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
            // usually buttons at the bottom of the dialog
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
                        Folder temp = new Folder(dialogText);
                        folders.add(temp);
                        controller.set(folders.length);
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
      desc: "Delete All Cards in these folders",
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
              Folder f = root.getFolders()[element];
              f.getDecks().forEach((i) {
                Deck d = i;
                d.getCards().forEach((j) {
                  iCueCard c = j;
                  root.addDeleted(c);
                });
              });
              print(root.getDeleted());
              root.removeFolder(element);
            });

            setState(() {
              controller.set(folders.length);
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

    Deck tempDeck = new Deck("Combined");
    if (list.length == 1) {
      for (int i = 0; i < folders[list[0]].getLength(); i++) {
        for (int j = 0; j < folders[list[0]].getDecks()[i].getLength(); j++) {
          tempDeck.addCard(folders[list[0]].getDecks()[i].getCards()[j]);
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Lists(
                  deck: tempDeck,
                )),
      );
      setState(() {
        controller.deselectAll();
      });
      return;
    }

    for (int z = 0; z < list.length; z++) {
      for (int i = 0; i < folders[list[z]].getLength(); i++) {
        for (int j = 0; j < folders[list[z]].getDecks()[i].getLength(); j++) {
          tempDeck.addCard(folders[list[z]].getDecks()[i].getCards()[j]);
        }
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Lists(
                deck: tempDeck,
              )),
    );
    setState(() {
      controller.deselectAll();
    });
  }

  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Folder row = folders.removeAt(oldIndex);
        folders.insert(newIndex, row);
      });
    }

    List<Container> tempList = new List();
    for (int index = 0; index < folders.length; index++) {
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
                    builder: (context) =>
                        DirectoryDeck(folder: folders[index], root: root)),
              );
            }
          },
          onDoubleTap: () {
            if (controller.isSelecting) {
              return;
            } else {
              List<iCueCard> temp = new List();
              for (int i = 0; i < folders[index].getLength(); i++) {
                for (int j = 0;
                    j < folders[index].getDecks()[i].getLength();
                    j++) {
                  temp.add(folders[index].getDecks()[i].getCards()[j]);
                }
              }
              Navigator.pushNamed(context, "/cardView",
                  arguments: {"list": temp, "title": folders[index].getName()});
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                folders[index].getName(),
                textAlign: TextAlign.center,
              ),
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
      floatingActionButton: controller.isSelecting == true
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.indigo[500],
              child: Icon(Icons.add),
              onPressed: () {
                _showDialog();
              }),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.indigo[500],
        elevation: 0,
        title: Text("Folders"),
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
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: () {
                    Deck d = new Deck("Recently Deleted");
                    d.setList(root.getDeleted());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Lists(deck: d, root: root)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.grading),
                  onPressed: () {
                    setState(() {
                      controller.isSelecting = true;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: Search(root));
                  },
                )
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
