import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CharacterInfo.dart';
import 'Characters.dart';

var url = 'https://swapi.co/api/people/?format=json&search=';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wars API Searcher',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Star Wars Character Searcher'),
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
  final myController = TextEditingController();
  List<String> names;
  List<dynamic> results;
  bool isSearching = false;

  void search(String term) async {
    isSearching = true;
    setState(() {});
    var response = await http.get(url + term);
//    print('Response body: ${response.body}');
//    return showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          // Retrieve the text the that user has entered by using the
//          // TextEditingController.
//          content: Text(((jsonDecode(response.body)['results'])[0])['name']),
//        );
//      },
//    );

//    print(jsonDecode(response.body)["results"]);
    results = jsonDecode(response.body)["results"];
    isSearching = false;
    setState(() {});
  }

  Widget searchResults() {
    if (isSearching != null && isSearching) {
      return CircularProgressIndicator();
    } else if (results == null || results.length < 1) {
      return Text(
        'No Search Results Found',
      );
    } else {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Card(
//                color:Colors.grey,
                elevation: 2,
                child: MaterialButton(
                  splashColor: Colors.cyan,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CharInfo(
                                    currentCharacter:
                                    Character.fromJson(results[index]))));
                  },
                  child: !(((results[index]["name"]).toString()).contains("Ã")) ?
                  Center(child: Text('${results[index]["name"]}')):
                  Center(child: Text('${(results[index]["name"]).toString().replaceAll("Ã©", "é")}'))
                  ,
                ),
              ),
            );
          });
    }
  }

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//          tooltip: "This is a button that will show a notification.",
//          onPressed: () {
//            return showDialog(
//              context: context,
//              builder: (context) {
//                return AlertDialog(
//                  content: Card(
//                    elevation: 0,
//                    color: Colors.white,
//                    child: OutlineButton(
//                      color: Colors.grey,
//                      textColor: Colors.blue,
//                      child: Text("Okay", style: TextStyle(
//                          color: Colors.blue, fontWeight: FontWeight.w300)),
//                    ),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(5),
//                      side: new BorderSide(color: Colors.grey, width: 1.0),
//                    ),
//                  ),
//                  title: Center(
//                      child: Text("Don't Click This!",
//                          style: TextStyle(color: Colors.black))),
//                  backgroundColor: Colors.white,
//                );
//              },
//            );
//          },
//          child: Icon(Icons.comment)),
      /*⚠*/
    appBar: AppBar(
        title: Center(
          child: Text(widget.title,
              style:
              TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: TextField(
                controller: myController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for a Character'),
              ),
              margin: EdgeInsets.all(20),
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 4.0,
                onPressed: () {
                  search(myController.text);
                },
                color: Colors.blue,
                child: Text("Go!")),
            Expanded(
              child: Center(
                child: searchResults(),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
