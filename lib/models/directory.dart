//import 'package:flutter/material.dart';
//import 'package:icue_cards/models/folder.dart';

class Directory {
  List _list;
  String _name;
  DateTime _time;
  String _order;

  Directory(name) {
    _name = name;
    _time = DateTime.now();
    _order = "default";
  }

  List getList() {
    return _list;
  }

  void setList(List list) {
    _list = list;
  }

  void addList(List cards) {
    _list.add(cards);
  }

  List removeList(int index) {
    List temp = _list[index];
    _list.removeAt(index);
    return temp;
  }

  void insertList(int index, List deck) {
    _list.insert(index, deck);
  }

  String getName() {
    return _name;
  }

  void setName(String newName) {
    _name = newName;
  }

  DateTime getTime() {
    return _time;
  }

  String getOrder() {
    return _order;
  }

  String setOrder(String newOrder) {
    return _order;
  }

  int getLength() {
    return _list.length;
  }
}
