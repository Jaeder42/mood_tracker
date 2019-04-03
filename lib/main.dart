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
  List<String> moods = [];
  _navigate() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoodEditor()),
    );
    fetchMoods();
  }

  @override
  void initState() {
    super.initState();
    fetchMoods();
  }

  fetchMoods() async {
    moods = (await fetch()).split(',');
    moods.removeLast();
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: moods.length > 0
          ? GridView.count(
              crossAxisCount: 2,
              children: moods.map<Widget>((mood) {
                var val = mood.split(';');
                return card(double.tryParse(val[0]), date: val[1]);
              }).toList())
          : Center(child: Text('No mood recorded, add one now!')),

      floatingActionButton: FloatingActionButton(
        onPressed: _navigate,
        tooltip: 'Add mood',
        child: Icon(Icons.insert_emoticon),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
