import 'package:flutter/material.dart';

class MoodEditor extends StatefulWidget {
  @override
  _MoodEditorState createState() => _MoodEditorState();
}

var label = (text, {size = 20.0, turn = 0}) => Padding(
    padding: EdgeInsets.only(top: 10),
    child: RotatedBox(
        quarterTurns: turn,
        child: Text(
          text,
          style: TextStyle(
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

  _goHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          title: Text('Enter Mood!'),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 150,
                    child: label(moodFace(this.mood), size: 100.0, turn: 1)),
                label('Mood'),
                slider(_setMood, this.mood),
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
