import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
//      theme: ThemeData(
//        backgroundColor: Colors.black12,
//        canvasColor: Colors.white10,
//        primarySwatch: Colors.teal,
//      ),
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(
        title: "Sebastian Park's Calculator",
      ),
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
  @override
  String out = "0";
  String _out = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  Widget buildButtonColor(String label, MaterialAccentColor pcolor) {
    return Expanded(
      child: new MaterialButton(
        elevation: 2.0,
        padding: new EdgeInsets.all(27.0),
//        padding: new EdgeInsets.all(90.0),
        child: Text(
          label,
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () => onButtonPressed(label),
        color: pcolor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    );
  }

  Widget buildButton(String label) {
    return Expanded(
      child: new MaterialButton(
        elevation: 2.0,
//        padding: new EdgeInsets.all(90.0),
        padding: new EdgeInsets.all(26.0),
        child: Text(label, style: TextStyle(fontSize: 20)),
        onPressed: () => onButtonPressed(
          label,
        ),
        color: Colors.white,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        out = "0";
        _out = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "÷" ||
          buttonText == "×") {
        num1 = double.parse(out);
        operand = buttonText;
        _out = "0";
      } else if (buttonText == ".") {
        if (!_out.contains(".")) {
          _out += ".";
        }
      } else if (buttonText == "±" && _out != "0.0") {
        out = (double.parse(out) * -1).toString();
//        out = _out;
      } else if (buttonText == "=") {
        num2 = double.parse(out);

        if (operand == "+") {
          _out = (num1 + num2).toString();
        } else if (operand == "-") {
          _out = (num1 - num2).toString();
        } else if (operand == "÷") {
          _out = (num1 / num2).toString();
        } else if (operand == "×") {
          _out = (num1 * num2).toString();
        }
        num1 = 0;
        num2 = 0;
        out = _out;
        _out = "0";
        operand = "";
      } else {
        _out += buttonText;
        out = double.parse(_out).toString();
        if (out.endsWith(".0")) {
          out = int.parse(_out).toString(); //prevents it from doing "1.0"
        }
        if (_out.endsWith("."))
          out = int.parse(_out).toString() +
              "."; //makes it so that you can see the decimal point when you type it in
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Container(
                child: Text(
              out,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
            ),
            Container(
                child: Text(
                  operand,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButtonColor("÷", Colors.pinkAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButtonColor("×", Colors.pinkAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButtonColor("-", Colors.pinkAccent)
                  ],
                ),
                Row(
                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        buildButton("0"),
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        buildButton("."),
//                        buildButton("+"),
//                      ],
//                    ),
                    buildButton("0"),
                    buildButton("."),
                    buildButton("±"),
                    buildButtonColor("+", Colors.pinkAccent)
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildButtonColor("AC", Colors.orangeAccent),
                    buildButtonColor("=", Colors.lightBlueAccent),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
