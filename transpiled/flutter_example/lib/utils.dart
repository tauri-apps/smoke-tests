import 'package:flutter/material.dart';

final Map<int, Color> boxColor = <int, Color>{
  2: Colors.blue[50],
  4: Colors.blue[100],
  8: Colors.blue[200],
  16: Colors.blue[300],
  32: Colors.blue[400],
  64: Colors.blue[500],
  128: Colors.blue[600],
  256: Colors.blue[700],
  512: Colors.blue[800],
  1025: Colors.blue[900],
};

final cellBoxColor = Color.fromRGBO(207, 216, 220, 0.5);

final borderColor = Color.fromRGBO(96, 125, 139, 0.75);

final EdgeInsets gameMargin = EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0);

final dialogTextStyle = TextStyle(color: Colors.white, fontSize: 20);

final boxTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: textColor,
);

final textColor = Colors.white;

final buttonGradient = LinearGradient(colors: [
  Color.fromRGBO(116, 116, 191, 1.0),
  Color.fromRGBO(52, 212, 212, 1.0)
]);

final backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue, Colors.greenAccent]);

final titleTextStyle = TextStyle(
  fontSize: 60.0,
  fontWeight: FontWeight.bold,
  color: textColor,
);

final boxBackground = Color.fromRGBO(96, 125, 149, 0.75);
