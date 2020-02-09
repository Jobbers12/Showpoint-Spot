import 'package:flutter/material.dart';

class Settings extends StatelessWidget {

final String currentShowName;
final String currentShowTimeStamp;

Settings({
  this.currentShowName,
  this.currentShowTimeStamp
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        
        padding: EdgeInsets.only(left: 56, right: 56, top: 56),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Current Show',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.grey[800])),
              ],
            ),
            Row(children: <Widget>[
              // Current Show File Name
              Text(
                currentShowName ?? 'NO DATA',
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .copyWith(color: Colors.black),
              ),
              // Last File Update - From Server
              Text(' | $currentShowTimeStamp',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 35))
            ]),
            Row(
              children: <Widget>[
                Text(
                  'User Preferances',
                  style: Theme.of(context).textTheme.title,
                )
              ],
            ),
            Row(children: <Widget>[
              // Selection of tracking mode. Saved as user preferance 
              Text('Tracking Mode'),
              Text(' (Color of changed values)',
                  style: Theme.of(context).textTheme.caption)
            ]),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  // groupValue: _tracking,
                  // onChanged: _handleTrackingModeChange,
                ),
                Text('Off'),
                Text(' (Only background colors change)',
                    style: Theme.of(context).textTheme.caption),
                Radio(
                  value: 0,
                  // groupValue: _tracking,
                  // onChanged: _handleTrackingModeChange,
                ),
                Text('Simple'),
                Text(' (Basic tracking colors on key changes)',
                    style: Theme.of(context).textTheme.caption),
                Radio(
                  value: 0,
                  // groupValue: _tracking,
                  // onChanged: _handleTrackingModeChange,
                ),
                Text('Tracking'),
                Text(' (Full tracking colours)',
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
