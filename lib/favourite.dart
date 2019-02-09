import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Favourites extends StatelessWidget {
  Set<WordPair> words = new Set<WordPair>();
  Favourites(Set<WordPair> words) {
    this.words = words;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = ListTile.divideTiles(
      context: context,
      tiles: words.map(
        (WordPair pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
            ),
            leading: CircleAvatar(
              child: Text(
                pair.asUpperCase.substring(0, 1),
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        },
      ),
    ).toList();
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Favourites'),
        ),
        body: new ListView(
          children: items,
        ));
  }
}
