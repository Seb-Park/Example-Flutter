import 'package:flutter/material.dart';

import 'Characters.dart';

class CharInfo extends StatefulWidget {
  final Character currentCharacter;

  CharInfo({this.currentCharacter});

  @override
  _CharInfoState createState() => _CharInfoState();
}

class _CharInfoState extends State<CharInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            widget.currentCharacter.name,
            style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 80.0, top: 8.0, right: 80.0, bottom: 8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Born: " + widget.currentCharacter.birthYear),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Height: " + widget.currentCharacter.height + "cm"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Mass: " + widget.currentCharacter.mass + " kg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Eyes: " + widget.currentCharacter.eyeColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Hair: " + widget.currentCharacter.hairColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Gender: " + widget.currentCharacter.gender),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Text("Vehicles Owned: " + (widget.currentCharacter.vehicles.length + widget.currentCharacter.starships.length).toString()),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
