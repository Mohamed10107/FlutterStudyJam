import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'favourite.dart';

final Set<WordPair> saved = new Set<WordPair>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter App', home: new Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Study Jam'),
      ),
      body: new Center(
        child: new RandomWords(),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new Favourites(saved);
          }));
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> suggestions = <WordPair>[];
  final TextStyle biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row in the ListView.
          if (i.isOdd) {
            return new Divider();
          }
          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // This calculates the actual number of word pairings in the ListView, minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          if (index >= suggestions.length) {
            // ...then generate 10 more and add them to the suggestions list.
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        });
  }

  Widget buildRow(WordPair pair) {
    final bool isAlreadySaved = saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      subtitle: Text("sub title data"),
      leading: CircleAvatar(
        child: Text(
          pair.asUpperCase.substring(0, 1),
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      trailing: new Icon(
        isAlreadySaved ? Icons.favorite : Icons.favorite_border,
        color: isAlreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isAlreadySaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }
}
