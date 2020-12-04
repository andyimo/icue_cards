import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class iCueCard {
  //the card object
  String _id;
  String _frontSide;
  String _backSide;
  Color _color;
  DateTime _time;
  AssetImage _image;

  iCueCard({frontSide, backSide, color, image}) {
    _frontSide = frontSide;
    _backSide = backSide;
    _color = color;
    _time = DateTime.now();
    final uuid = Uuid();
    _id = uuid.v1().toString();
    _image = image;
  }

  void setImage(AssetImage image) {
    _image = image;
  }

  AssetImage getImage() {
    return _image;
  }

  String getId() {
    return _id;
  }

  String getFront() {
    return _frontSide;
  }

  void setFront(String front) {
    _frontSide = front;
  }

  String getBack() {
    return _backSide;
  }

  void setBack(String back) {
    _backSide = back;
  }

  Color getColor() {
    return _color;
  }

  void setColor(Color color) {
    _color = color;
  }

  DateTime getTime() {
    return _time;
  }
}
