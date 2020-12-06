import '../models/iCueCard.dart';

class Deck {
  List<iCueCard> _cards;
  String _deckName;
  DateTime _time;
  String _order;
  Deck(this._deckName) {
    _cards = new List();
    _time = DateTime.now();
  }

  void sortByTime() {
    _cards.sort((item1, item2) => item1.getTime().compareTo(item2.getTime()));
  }

  void sortByName() {
    _cards.sort((item1, item2) => item1
        .getFront()
        .toLowerCase()
        .compareTo(item2.getFront().toLowerCase()));
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
    return _deckName;
  }

  iCueCard removeCard(int index) {
    iCueCard temp = _cards[index];
    _cards.removeAt(index);
    return temp;
  }

  void setName(String newName) {
    _deckName = newName;
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
