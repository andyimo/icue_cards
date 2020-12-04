import 'package:flutter/material.dart';
import 'package:icue_cards/models/deck.dart';
import 'package:icue_cards/models/folder.dart';
import 'HeadsUp.dart';
import '../models/root.dart';
import '../models/iCueCard.dart';

class HeadsUpStart extends StatefulWidget {
  @override
  _HeadsUpStartState createState() => _HeadsUpStartState();
}

class _HeadsUpStartState extends State<HeadsUpStart> {
  var _dropFolder;
  var _dropDeck;
  var _dropNum;
  Folder _currentFolder;
  Deck currentDeck;
  int index = 0;

  List<String> cards = ["Math", "Music", "English", "Computer Science"];
  //Create a root object here
  Root root = new Root("root");
  List<Folder> folders = new List<Folder>();
  //a list of string to store the name of the folders
  List<String> foldername = new List<String>();

  //a list of exist deck
  List<Deck> decks = new List<Deck>();
  //a lsit of string to store the name of the deck
  List<String> deckname = new List<String>();

  //the init function is to add the cards, decks and folders to the root
  @override
  void initState() {
    super.initState();

    Folder folder = Folder("COMP 3004");
    Folder folder2 = Folder("COMP 3000");
    Folder folder3 = Folder("COMP 3007");
    Folder folder4 = Folder("COMP 3804");

    root.addFolder(folder);
    root.addFolder(folder2);
    root.addFolder(folder3);
    root.addFolder(folder4);

    Deck deck = Deck("Chapter 1");
    Deck deck2 = Deck("Chapter 2");
    Deck deck3 = Deck("Chapter 3");
    Deck deck4 = Deck("Chapter 4");

    folder.addDeck(deck);
    folder.addDeck(deck2);
    folder.addDeck(deck3);
    folder.addDeck(deck4);

    deck.addCard(new iCueCard(
        frontSide: 'Who is the best player in 21st century',
        backSide: 'Messi',
        color: Colors.green));
    deck.addCard(iCueCard(
        frontSide: "sample question2",
        backSide: 'sample answer2',
        color: Colors.amber));
    deck.addCard(new iCueCard(
        frontSide: 'sample question3',
        backSide: 'sample answer3',
        color: Colors.blue));
    deck.addCard(new iCueCard(
        frontSide: 'sample question4',
        backSide: 'sample answer4',
        color: Colors.blue));

    folders = root.getFolders();
    //use a for loop to get all the names of the folder in the root
    for(int i=0; i<root.getLength(); i++){
      foldername.add(folders[i].getName());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Heads UP Page'),
      ),
      body: Center(
        child: Column(children: [
          new DropdownButton(
            //isExpanded: true,
            items: foldername.map((String value){
              return new DropdownMenuItem(
                value: value,
                child: Text(value),
                );
            }).toList(),
            onChanged: (value){
              setState(() {
                _dropFolder = value;

                for(int i=0; i<root.getLength();i++){
                  if(folders[i].getName() == _dropFolder){
                    _currentFolder = folders[i];
                    break;
                  }
                }
                decks = _currentFolder.getDecks();
                for(int i=0; i<_currentFolder.getLength(); i++){
                  deckname.add(decks[i].getName());
                }
              });
            },
            value: _dropFolder,
            hint: Text('Select the Folder'),
          ),
          new DropdownButton(
            //isExpanded: true,
            items: deckname.map((String value){
              return new DropdownMenuItem(
                value: value,
                child: Text(value),
                );
            }).toList(),
            onChanged: (value){
              setState(() {
                _dropDeck = value;

                for(int i=0; i<_currentFolder.getLength(); i++){
                  if(decks[i].getName() == _dropDeck){
                    currentDeck = decks[i];
                    break;
                  }
                }
              });
            },
            value: _dropDeck,
            hint: Text('Select the Deck'),
            ),
            new DropdownButton(
              //isExpanded: true,
              items: <String>["5", "10", "15", "20", "all"].map((String value){
                return new DropdownMenuItem(
                  value: value,
                  child: Text(value),
                  );
                }).toList(),
              onChanged: (value){
                setState(() {
                  _dropNum = value;
                });
              },
              value: _dropNum,
              hint: Text('Select the Question Number'),
            ),
          new RaisedButton(
            child: Text('Start'),
            color: Colors.blueAccent[600],
            
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeadsUp(deck: currentDeck, category:_dropDeck, questionNum:_dropNum)),
            ),
            
            /*
            onPressed: () {
                    int orientation = MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 0
                        : 1;
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      return HeadsUp(category:_dropClassValue, questionNum:_dropNumValue);
                    }));
                  },*/
          ),
        ]),
      ),
    );
  }
}
