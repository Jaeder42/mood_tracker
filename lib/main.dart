import 'package:flutter/material.dart';

import 'views/mood_editor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodTracker',
      home: MyHomePage(title: 'Mood Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoodEditor()),
    );
  }

  _fetchDays() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Card(
            color: Colors.yellow[100],
            child: Center(child:label(moodFace(3), size: 100.0, turn: 1)),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigate,
        tooltip: 'Add mood',
        child: Icon(Icons.insert_emoticon),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
