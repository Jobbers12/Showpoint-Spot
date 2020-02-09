import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.orange,
    hintColor: Colors.white,
    dividerColor: Colors.white,
    buttonColor: Colors.white,
    backgroundColor: Colors.white,
    canvasColor: Colors.white,

    fontFamily: 'Montserrat',

    textTheme: TextTheme(
      //subhead: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w200), // Headings
      // display4: TextStyle(fontSize: 110.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1), // Large Int & Who
      // display3: TextStyle(fontSize: 55.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1), // Normal Large (Current Cue)
      // display2: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2), // Notes (Current Cue)
      // display1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2) // Upcoming Cues

    )
  );
}