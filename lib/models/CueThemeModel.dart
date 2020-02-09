import 'package:flutter/material.dart';

// TextStyles for Cue insormation.

class CueThemeModel {
  final TextStyle cueLabel; // Label & Headings
  final TextStyle display1; // Upcoming Cues
  final TextStyle display2; // Notes (Current Cue)
  final TextStyle display3; // Normal Large (Current Cue)
  final TextStyle display4; // Large (Int & Who)
  
  CueThemeModel({
    this.cueLabel,
    this.display1,
    this.display2,
    this.display3,
    this.display4,
  });
}