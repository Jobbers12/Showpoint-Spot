import 'CueModel.dart';

class ShowPayloadModel {
  List<CueModel> cues;
  //List<MetadataModel> metadata;
  String currentShowID;
  String currentShowName;
  String currentShowTimeStamp;
  
  ShowPayloadModel.fromJson(json) {
    this.cues = _parseCues(json['cues']); // Our Second Nested .fromJson Call. It's inside the _parseCues method.
    this.currentShowID = json['currentShowID'];
    this.currentShowName = json['currentShowName'];
    this.currentShowTimeStamp = json['currentShowTimeStamp'];
  }

  List<CueModel> _parseCues(List<dynamic> json) {
    return json.map((jsonCue) => CueModel.fromJson(jsonCue)).toList();
  }
}