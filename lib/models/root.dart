import 'package:icue_cards/models/folder.dart';
import 'package:icue_cards/models/Deck.dart';
import 'package:icue_cards/models/iCueCard.dart';

class Root {
  List<Folder> _folders;
  String _name;
  DateTime _time;
  String _order;
  List<iCueCard> _recentlyDeleted;

  Root(name) {
    _folders = new List();
    _recentlyDeleted = new List();
    _name = name;
    _time = DateTime.now();
    _order = "default";
  }

  void addDeleted(iCueCard c) {
    _recentlyDeleted.add(c);
  }

  List getDeleted() {
    return _recentlyDeleted;
  }

  void removeDeleted(int i) {
    _recentlyDeleted.removeAt(i);
  }

  List<String> getFolderNames() {
    List<String> ret = new List();
    for (int i = 0; i < _folders.length; i++) {
      ret.add(_folders[i].getName());
    }
    return ret;
  }

  List getFolders() {
    return _folders;
  }

  void setFolder(List<Folder> f) {
    _folders = f;
  }

  int getLength() {
    return _folders.length;
  }

  void addFolder(Folder f) {
    _folders.add(f);
  }

  Folder removeFolder(int index) {
    Folder temp = _folders[index];
    _folders.removeAt(index);
    return temp;
  }
}
