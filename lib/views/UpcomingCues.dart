import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:showpoint_spot/models/CueModel.dart';
import 'package:showpoint_spot/theme/CueTheme.dart';

class UpcomingCues extends StatelessWidget {
  final CueModel cueData;

  final String currentCueID;

  final Color bgColor;

  const UpcomingCues(
      {@required this.cueData,
      this.currentCueID,
      this.bgColor = Colors.white,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentCueID == '-1' || cueData == null) {
      return NullUpcomingCueFallback();
    }

    return Container(
      color: bgColor,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('WHO', style: CueTheme.of(context).data.cueLabel)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(cueData.who.value.toUpperCase() ?? '',
                              style: CueTheme.of(context).data.display1))
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('INT', style: CueTheme.of(context).data.cueLabel)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(_intensity(cueData.intensity.value) ?? '',
                              style: CueTheme.of(context).data.display1))
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('SIZE', style: CueTheme.of(context).data.cueLabel),
                  Text(cueData.size.value ?? '',
                      style: CueTheme.of(context).data.display1)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('FRAME', style: CueTheme.of(context).data.cueLabel),
                  Text(cueData.frame.value ?? '',
                      style: CueTheme.of(context).data.display1)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('TIME', style: CueTheme.of(context).data.cueLabel),
                  Text(cueData.time.value ?? '',
                      style: CueTheme.of(context).data.display1)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('LX CUE', style: CueTheme.of(context).data.cueLabel),
                  Text(cueData.lxCue.value.toString() ?? '',
                      style: CueTheme.of(context).data.display1)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('LOCATION', style: CueTheme.of(context).data.cueLabel),
                  Text(cueData.location.value ?? '',
                      style: CueTheme.of(context).data.display1)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // Replaces 100 & 0 with FF & OUT for displaying intensity information
  String _intensity(int intensity) {
    if (intensity == 100) {
      return 'FF';
    } else if (intensity == 0) {
      return 'OUT';
    }
    return intensity.toString();
  }
}

class NullUpcomingCueFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.amber[100],
        child: Text('NO UPCOMING CUES',
            style: CueTheme.of(context).data.display1));
  }
}
