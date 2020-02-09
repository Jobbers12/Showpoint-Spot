import 'package:showpoint_spot/models/CueModel.dart';

class AppStateModel {
  final List<CueModel> cues; // List of all cues
  String currentCueID; // Currently selected cue (Visiable to client)
  final String currentShowID;
  final String currentShowName;
  final String currentShowTimeStamp;

  AppStateModel({
    this.cues,
    this.currentCueID,
    this.currentShowID,
    this.currentShowName,
    this.currentShowTimeStamp,
  });

  AppStateModel copyWith({
    List<CueModel> cues,
    String currentCueID,
    String currentShowID,
    String currentShowName,
    String currentShowTimeStamp,
  }) {
    return AppStateModel(
      cues: cues ?? this.cues,
      currentCueID: currentCueID ?? this.currentCueID,
      currentShowID: currentShowID ?? this.currentShowID,
      currentShowName: currentShowName ?? this.currentShowName,
      currentShowTimeStamp: currentShowTimeStamp ?? this.currentShowTimeStamp
    );
  }
}
