import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../models/root.dart';
import '../models/folder.dart';
import '../models/deck.dart';

class Search extends SearchDelegate<String> {
  Root root;
  Search(root) {
    this.root = root;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  Widget buildSuggestions(BuildContext context) {
    List sList = new List();
    if (query.isEmpty == false) {
      for (int i = 0; i < root.getLength(); i++) {
        Folder folder = root.getFolders()[i];
        for (int j = 0; j < folder.getLength(); j++) {
          Deck deck = folder.getDecks()[j];
          for (int k = 0; k < deck.getLength(); k++) {
            List cards = deck.getCards();
            if (cards[k].getFront().contains(query) ||
                cards[k].getBack().contains(query)) {
              sList.add(cards[k]);
            }
          }
        }
      }
    }

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.content_copy),
        ),
        title: Container(
          child: Text(
            sList[index].getFront(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        subtitle: Text(
          sList[index].getBack(),
          style: TextStyle(fontSize: 18),
        ),
      ),
      itemCount: sList.length,
    );

    return Container();
  }
}
