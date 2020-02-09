import 'package:flutter/material.dart';
import 'package:showpoint_spot/AppContainer.dart';
import 'package:showpoint_spot/models/CueModel.dart';
import 'package:showpoint_spot/models/CueThemeModel.dart';
import 'package:showpoint_spot/keys/navigatorKey.dart';
import 'package:showpoint_spot/theme/style.dart';
import 'package:showpoint_spot/views/AppMenu.dart';
import 'package:showpoint_spot/views/GoToCue.dart';
import 'package:showpoint_spot/views/currentCue.dart';
import 'package:showpoint_spot/views/upcomingCues.dart';
import 'package:showpoint_spot/theme/CueTheme.dart';

void main() => runApp(TopApp());

class TopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spot',
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        navigatorKey:
            navigatorKey, // Remove in future. This is defunt code for the settings page
        home: Material(
            child: CueTheme(data: _buildCueTheme(), child: AppContainer())));
  }

  // Custom Cue Theme Colors
  CueThemeModel _buildCueTheme() {
    return CueThemeModel(
      display4: TextStyle(
          fontSize: 110.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1),
      display3: TextStyle(
          fontSize: 55.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1),
      display2: TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.2),
      display1: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.2,
      ),
      cueLabel: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w200),
    );
  }
}

class App extends StatelessWidget {
  final List<CueModel> cues;

  final String currentCueID;

  final String currentShowName;
  final String currentShowTimeStamp;

  final CueModel currentCue;
  final CueModel nextCue;
  final CueModel futureCue;

  final dynamic onNextButtonPressed;
  final dynamic onBackButtonPressed;

  final dynamic onTestButtonPressed;

  final dynamic onCueSelect;

  App({
    this.cues,
    this.currentCueID,
    this.currentCue,
    this.nextCue,
    this.futureCue,
    this.onCueSelect,
    this.onTestButtonPressed,
    this.onNextButtonPressed,
    this.onBackButtonPressed,
    this.currentShowName,
    this.currentShowTimeStamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:
          Drawer(child: GoToCueDrawer(cues: cues, onCueSelect: onCueSelect)),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('Next'),
                onPressed: onNextButtonPressed,
              ),
              RaisedButton(
                child: Text('Back'),
                onPressed: onBackButtonPressed,
              ),
            ],
          ),

          // LANDSCAPE
          Stack(
            children: <Widget>[
              CurrentCue(cueData: currentCue, currentCueID: currentCueID),
              Positioned(
                top: 0,
                right: 0,
                child: AppMenu(currentShowName: currentShowName, currentShowTimeStamp: currentShowTimeStamp),
              ),
              Positioned(
                top: 0,
                right: 32,
                child: GoToCueBtn(),
              ),
            ],
          ),
          Expanded(
              child: UpcomingCues(
                  bgColor: Colors.grey[300],
                  cueData: nextCue,
                  currentCueID: nextCue.toString())),
          Expanded(
              child: UpcomingCues(
                  bgColor: Colors.white,
                  cueData: futureCue,
                  currentCueID: futureCue.toString())),
        ],
      ),
    );
  }
}

// UUID
