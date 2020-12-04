import 'package:icue_cards/models/folder.dart';

class Root {
  List<Folder> _folders;
  String _name;
  DateTime _time;
  String _order;
  Root(name) {
    _folders = new List();
    _name = name;
    _time = DateTime.now();
    _order = "default";
  }

  List getFolders() {
    return _folders;
  }

  int getLength() {
    return _folders.length;
  }

  Folder removeFolder(int index) {
    Folder temp = _folders[index];
    _folders.removeAt(index);
    return temp;
  }

  void addFolder(Folder f) {
    _folders.add(f);
  }
}
