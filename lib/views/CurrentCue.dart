import 'package:flutter/material.dart';
import 'package:showpoint_spot/models/CueModel.dart';
import 'package:meta/meta.dart';
import 'package:showpoint_spot/theme/CueTheme.dart';

class CurrentCue extends StatelessWidget {
  final CueModel cueData;
  final String currentCueID;

  const CurrentCue({
    @required this.cueData,
    this.currentCueID,
    Key key,
  }) : super(key: key);

  final double currentCueHeightMultiplier = 0.60;

  @override
  Widget build(BuildContext context) {
    if (currentCueID == '-1' || cueData == null) {
      return NullCueFallback(
        heightMultiplier: currentCueHeightMultiplier,
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          height:
              MediaQuery.of(context).size.height * currentCueHeightMultiplier,
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          color: Colors.green[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('WHO',
                            style: CueTheme.of(context).data.cueLabel,
                            textAlign: TextAlign.left),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: cueData.who.value.toUpperCase() ?? '',
                              style: CueTheme.of(context).data.display4,
                        ),
                        ),],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('INTENSITY',
                            style: CueTheme.of(context).data.cueLabel),
                        RichText(
                            //overflow: cueData.intensity.toLowerCase() == 'full' ? TextOverflow.clip : TextOverflow.ellipsis,
                            text: TextSpan(
                                text: _currentIntensity(cueData.intensity
                                    .value), //cueData.intensity.toUpperCase() ?? '',
                                style: CueTheme.of(context).data.display4))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('SIZE', style: CueTheme.of(context).data.cueLabel),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: cueData.size.value ?? '',
                              style: CueTheme.of(context).data.display3),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Text('FRAME',
                            style: CueTheme.of(context).data.cueLabel),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: cueData.frame.value ?? '',
                              style: CueTheme.of(context).data.display3),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Text('TIME', style: CueTheme.of(context).data.cueLabel),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: cueData.time.value ?? '',
                              style: CueTheme.of(context).data.display3),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text('LX CUE',
                            style: CueTheme.of(context).data.cueLabel),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: _removeDecimalZeroFormat(
                                      cueData.lxCue.value) ??
                                  '',
                              style: CueTheme.of(context).data.display3),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('LOCATION',
                            style: CueTheme.of(context).data.cueLabel),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: cueData.location.value ?? '',
                              style: CueTheme.of(context).data.display3),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('NOTES', style: CueTheme.of(context).data.cueLabel),
                      Container(
                        width: MediaQuery.of(context).size.width * .95,
                        child: Text(
                          cueData.notes ?? '',
                          style: CueTheme.of(context).data.display2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }

  // Replaces 100 & 0 with FF & OUT for displaying intensity information
  String _currentIntensity(int currentInt) {
    if (currentInt == 100) {
      return 'FF';
    } else if (currentInt == 0) {
      return 'OUT';
    }
    return currentInt.toString();
  }
}

// Remove the .0 on cue numbers
String _removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}

// If current cue returns null
class NullCueFallback extends StatelessWidget {
  final double heightMultiplier;

  NullCueFallback({this.heightMultiplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amber[100],
      height: MediaQuery.of(context).size.height * heightMultiplier,
      child: Center(
        child:
            Text('NO CURRENT CUE', style: CueTheme.of(context).data.display3),
      ),
    );
  }
}
