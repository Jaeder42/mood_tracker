import 'dart:async';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<File> get localFile async {
  final directory = await getApplicationDocumentsDirectory();

  final path = directory.path;
  return File('$path/mood.txt');
}

fetch() async {
  try {
    return await (await localFile).readAsString();
  } catch (_) {
    return '';
  }
}

String get dateNow {
  return formatDate(DateTime.now(), [d, ' ', MM, ' ', HH, ':', nn]);
}

card(double mood, {String date}) {
  return Card(
      color: Colors.yellow[100],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipOval(),
            Center(child: label(moodFace(mood), size: 100.0, turn: 1)),
            label(date != null ? date : dateNow, size: 12.0),
          ]));
}

write(data) async {
  return (await localFile).writeAsString(data);
}

var label = (text, {size = 20.0, turn = 0}) => Padding(
    padding: EdgeInsets.only(top: 10),
    child: RotatedBox(
        quarterTurns: turn,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff666666),
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        )));

moodFace(double mood) {
  switch (mood.round()) {
    case 0:
      return '=(';
    case 1:
      return '=|';
    case 2:
      return '=)';
    default:
      return '=D';
  }
}

class MoodEditor extends StatefulWidget {
  @override
  _MoodEditorState createState() => _MoodEditorState();
}

class _MoodEditorState extends State<MoodEditor> {
  double mood = 2;

  var slider = (change, value) => Slider(
        onChanged: change,
        value: value,
        min: 0,
        max: 3,
      );

  _setMood(double value) {
    mood = value;
    setState(() => {});
  }

  _goHome() async {
    write('$mood;$dateNow,' + (await fetch()));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Enter Mood!'),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height: 180, width: 180, child: card(mood)),
                label('Mood'),
                slider(_setMood, mood),
                Center(
                    child: GestureDetector(
                        onTap: _goHome,
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 100,
                            height: 50,
                            child: Center(
                                child: Text(
                              'OK',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )))))
              ],
            )));
  }
}
