/* The card creation screen
   [used to create a card]
   Author: Henry Tu
*/

import 'package:flutter/material.dart';
import '../models/iCueCard.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nice_button/nice_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:photo_view/photo_view.dart';

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
  Color imageButtonColor = Colors.grey[800];
  String buttonText;
  //PickedFile _imageFile;
  AssetImage _assetImage;
  dynamic _pickImageError;
  bool isVideo = false;
  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    await _displayPickImageDialog(context,
        (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );
        if (pickedFile == null) {
          return;
        }
        setState(() {
          //_imageFile = pickedFile;
          _assetImage = AssetImage(pickedFile.path);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

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
    iCueCard card;
    i++;
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;

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

    Widget _previewImage() {
      final Text retrieveError = _getRetrieveErrorWidget();
      if (retrieveError != null) {
        return retrieveError;
      }
      if (_assetImage != null) {
        setState(() {
          imageButtonColor = Colors.blue;
        });
        // return Semantics(
        //     child: Image.file(File(_imageFile.path)),
        //     label: 'image_picker_example_picked_image');
      }
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController1,
                autofocus: true,
                onEditingComplete: create,
                decoration: InputDecoration(labelText: 'Front'),
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              TextField(
                maxLength: 450,
                minLines: 1,
                maxLines: 7,
                controller: titleController2,
                autofocus: true,
                onEditingComplete: create,
                decoration: InputDecoration(labelText: 'Back'),
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  IconButton(
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
                  InkWell(
                    onLongPress: () async {
                      if (_assetImage != null) {
                        print(_assetImage);
                        await showDialog(
                            context: context,
                            builder: (_) => ImageDialog(_assetImage));
                      }
                    },
                    onDoubleTap: () {
                      setState(() {
                        _assetImage = null;
                        imageButtonColor = Colors.grey[800];
                      });
                    },
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                      iconSize: 45,
                      color: imageButtonColor,
                      onPressed: () {
                        //_imageFile = null;
                        isVideo = false;
                        _onImageButtonPressed(ImageSource.gallery,
                            context: context);
                      },
                    ),
                  )
                ],
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
        ),
      );
    }

    if (rcvdData != null) {
      //it's edit
      card = rcvdData["card"];
      currentColor = card.getColor();
      buttonText = "Save";
      if (i == 1) {
        _assetImage = card.getImage();
        titleController1 = new TextEditingController(text: card.getFront());
        titleController2 = new TextEditingController(text: card.getBack());
      }
    } else {
      buttonText = "Add";

      if (i == 1) {
        titleController1 = new TextEditingController();
        titleController2 = new TextEditingController();
      }
    }
    return Scaffold(
        // the page to create a card
        appBar: AppBar(title: Text("New Card")),
        body: _previewImage());
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
        'image': _assetImage == null ? null : _assetImage,

        //FileImage(File(_imageFile.path))
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
      } else {
        isVideo = false;
        setState(() {
          _assetImage = AssetImage(response.file.path);
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return onPick(null, null, null);
  }

  Widget ImageDialog(AssetImage a) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: PhotoView(
        imageProvider: a,
      )),
    );
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
