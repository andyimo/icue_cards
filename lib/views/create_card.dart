import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nice_button/nice_button.dart';
import 'package:get/get.dart';

class Result<T> {
  String front;
  String back;
  Color color;
}

class NewCard extends StatefulWidget {
  final iCueCard c;

  NewCard({this.c});

  @override
  _NewCardState createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  TextEditingController titleController1;
  TextEditingController titleController2;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int i = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    i++;
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;

    iCueCard card;
    if (rcvdData != null) {
      card = rcvdData["card"];
    }
    String front = rcvdData == null ? "" : card.getFront();
    String back = rcvdData == null ? "" : card.getBack();
    String buttonText = "Add";

    if (rcvdData != null) {
      //it's edit
      currentColor = card.getColor();
      buttonText = "Save";
    }
    if (i == 1) {
      titleController1 = new TextEditingController(text: front);
      titleController2 = new TextEditingController(text: back);
    }

    void changeColor(Color color) {
      setState(() {
        pickerColor = color;
        if (rcvdData == null) {
          currentColor = pickerColor;
        } else {
          card.setColor(pickerColor);
        }
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
        // the page to create a card
        appBar: AppBar(title: Text("New Card")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                maxLength: 450,
                minLines: 1,
                maxLines: 7,
                controller: titleController1,
                autofocus: true,
                onEditingComplete: create,
                decoration: InputDecoration(labelText: 'Front'),
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              TextField(
                controller: titleController2,
                autofocus: true,
                onEditingComplete: create,
                decoration: InputDecoration(labelText: 'Back'),
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    icon: Icon(Icons.color_lens),
                    iconSize: 45,
                    color: currentColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 15),
              NiceButton(
                width: 180,
                elevation: 8.0,
                radius: 52.0,
                text: buttonText,
                background: Colors.blue,
                onPressed: () => create(),
              ),
            ],
          ),
        ));
  }

  void create() async {
    if (titleController1.text.length == 0 ||
        titleController2.text.length == 0) {
      Get.snackbar('I know you can do better than this', 'Try Harder');
    } else {
      //the function returns the text back to the main page, in the future will be send to database as well.
      Navigator.pop(context, {
        'frontside': titleController1.text,
        'backside': titleController2.text,
        'color': currentColor,
      });
    }
  }
}
