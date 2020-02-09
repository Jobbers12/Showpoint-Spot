import 'package:meta/meta.dart';

import 'ShowValueModel.dart';

class CueModel {
  final String uid; //string
  final int spotCue; //int
  final ShowValueModel<String> who; //string
  final ShowValueModel<int> intensity; //int
  final ShowValueModel<String> size; //string
  final ShowValueModel<String> frame; //string
  final ShowValueModel<String> time; //string
  final ShowValueModel<double> lxCue; //double
  final ShowValueModel<String> location; //string
  final String notes; //string

  CueModel(
      {@required this.uid,
      @required this.spotCue,
      this.who,
      this.intensity,
      this.size,
      this.frame,
      this.time,
      this.lxCue,
      this.location,
      this.notes
    });

  CueModel.fromJson(Map<String, dynamic> json) :
    this.uid = json['uid'],
    this.spotCue = json['spotCue'],
    this.who = ShowValueModel<String>.fromJson(json['who']),
    this.intensity = ShowValueModel<int>.fromJson(json['intensity']),
    this.size = ShowValueModel<String>.fromJson(json['size']),
    this.frame = ShowValueModel<String>.fromJson(json['frame']),
    this.time = ShowValueModel<String>.fromJson(json['time']),
    this.lxCue = ShowValueModel<double>.fromJson(json['lxCue']),
    this.location = ShowValueModel<String>.fromJson(json['location']),
    this.notes = json['notes'];
}
