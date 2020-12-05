import '../models/deck.dart';

class Folder {
  List<Deck> _decks;
  String _name;
  DateTime _time;
  String _order;
  Folder(this._name) {
    _decks = new List();
    _time = DateTime.now();
    _order = "default";
  }

  List<String> getDeckNames() {
    List<String> ret = new List();
    for (int i = 0; i < _decks.length; i++) {
      ret.add(_decks[i].getName());
    }
    return ret;
  }

  void setList(List<Deck> list) {
    _decks = list;
  }

  void addDeck(Deck cards) {
    _decks.add(cards);
  }

  Deck removeDeck(int index) {
    Deck temp = _decks[index];
    _decks.removeAt(index);
    return temp;
  }

  void insertDeck(int index, Deck deck) {
    _decks.insert(index, deck);
  }

  List getDecks() {
    return _decks;
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
    return _decks.length;
  }
}
