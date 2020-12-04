import 'package:flutter/material.dart';
import 'HeadsUp.dart';

class HeadsUpStart extends StatefulWidget {
  @override
  _HeadsUpStartState createState() => _HeadsUpStartState();
}

class _HeadsUpStartState extends State<HeadsUpStart> {
  var _dropClassValue;
  var _dropNumValue;
  int index = 0;

  List<String> cards = ["Math", "Music", "English"];

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
            items: <String>["Math", "Music", "English"].map((String value){
              return new DropdownMenuItem(
                value: value,
                child: Text(value),
                );
            }).toList(),
            onChanged: (value){
              setState(() {
                _dropClassValue = value;
              });
            },
            value: _dropClassValue,
            ),
            new DropdownButton(
              //isExpanded: true,
              items: <String>["10", "20", "30"].map((String value){
                return new DropdownMenuItem(
                  value: value,
                  child: Text(value),
                  );
                }).toList(),
              onChanged: (value){
                setState(() {
                  _dropNumValue = value;
                });
              },
              value: _dropNumValue,
            ),
          new RaisedButton(
            child: Text('Start'),
            color: Colors.blueAccent[600],
            
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeadsUp(category:_dropClassValue, questionNum:_dropNumValue)),
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
