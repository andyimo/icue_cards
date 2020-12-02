import '../models/iCueCard.dart';

class Deck {
  List<iCueCard> _cards;
  String _name;
  DateTime _time;
  String _order;
  Deck(this._name) {
    _cards = new List();
    _time = DateTime.now();
  }

  void setList(List<iCueCard> list) {
    _cards = list;
  }

  void addCard(iCueCard card) {
    _cards.add(card);
  }

  void insertCard(int index, iCueCard card) {
    _cards.insert(index, card);
  }

  List getCards() {
    return _cards;
  }

  String getName() {
    return _name;
  }

  iCueCard removeCard(int index) {
    iCueCard temp = _cards[index];
    _cards.removeAt(index);
    return temp;
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
    return _cards.length;
  }
}
