import 'package:flutter/material.dart';
import 'package:icue_cards/models/deck.dart';
import 'package:icue_cards/models/folder.dart';
import 'HeadsUp.dart';
import '../models/root.dart';
import '../models/iCueCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeadsUpStart extends StatefulWidget {
  final Root root;
  HeadsUpStart({this.root});
  @override
  _HeadsUpStartState createState() => _HeadsUpStartState(root: this.root);
}

class _HeadsUpStartState extends State<HeadsUpStart> {
  final Root root;
  _HeadsUpStartState({this.root});
  var _dropFolder;
  var _dropDeck;
  var _dropNum ;
  Folder _currentFolder;
  Deck currentDeck;
  int index = 0;
  bool isEmpty1 = false;
  bool isEmpty2 = false;
  bool notInvoke1 = true;
  bool notInvoke2 = true;
  bool notInvoke3 = true;
  int counter;


  //List<String> cards = ["Math", "Music", "English", "Computer Science"];
  //Create a root object here
 // Root root1 = new Root("root");
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    /*
    Folder folder = Folder("COMP 3004");
    Folder folder2 = Folder("COMP 3000");
    Folder folder3 = Folder("COMP 3007");
    Folder folder4 = Folder("COMP 3804");

    root1.addFolder(folder);
    root1.addFolder(folder2);
    root1.addFolder(folder3);
    root1.addFolder(folder4);

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
        
    */
    folders = root.getFolders();
    //use a for loop to get all the names of the folder in the root
    for(int i=0; i<root.getLength(); i++){
      foldername.add(folders[i].getName());
    }

  }

  showAlertDialog(BuildContext context) {
 
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
  
    AlertDialog alert = AlertDialog(
      title: Text("Attention!"),
      content: Text( "The current deck/folder you selected is empty",
                  style: TextStyle(color: Colors.red, fontSize: 20.0),),
      actions: [
        cancelButton,
      ],
    );
  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Heads Up Page'),
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
                notInvoke1 = false;
                _dropFolder = value;
                print('$_dropFolder');
                for(int i=0; i<root.getLength();i++){
                  if(folders[i].getName() == _dropFolder){
                    _currentFolder = folders[i];
                    break;
                  }
                }
                decks = _currentFolder.getDecks();
                //deckname.clear();
                //List<String> tmp;
                for(int i=0; i<_currentFolder.getLength(); i++){
                  deckname.add(decks[i].getName());
                  //tmp.add(decks[i].getName());
                }
                //deckname = tmp;
                
                if(_currentFolder.getLength()==0){
                  isEmpty1 = true;
                  showAlertDialog(context);
                }else{
                  isEmpty1 = false;
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
                notInvoke2 = false;
                _dropDeck = value;
                print('$_dropDeck');
                for(int i=0; i<_currentFolder.getLength(); i++){
                  if(decks[i].getName() == _dropDeck){
                    currentDeck = decks[i];
                    break;
                  }
                }
                if(currentDeck.getLength() == 0){
                  isEmpty2 = true;
                  showAlertDialog(context);
                } else{
                  isEmpty2 = false;
                }
                print('$isEmpty2');
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
                  notInvoke3 = false;
                  _dropNum = value;
                });
              },
              value: _dropNum,
              hint: Text('Select the Question Number'),
            ),
          new RaisedButton(
            child: Text('Start'),
            color: Colors.blueAccent[600],
            
            onPressed: () {
              if(notInvoke1 || notInvoke2 || notInvoke3){
                null;
                showAlertDialog(context);
              }else{
                if(isEmpty1 || isEmpty2){
                  showAlertDialog(context);
                }else{
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HeadsUp(root: root, deck: currentDeck, category:_dropDeck, questionNum:_dropNum)),
                  );
                }
              }
            }
            
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
