import 'package:flutter/material.dart';
import 'package:showpoint_spot/models/CueModel.dart';

class GoToCueBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.gps_fixed),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}

class GoToCueDrawer extends StatelessWidget {
  final List<CueModel> cues;
  final dynamic onCueSelect;

  GoToCueDrawer({
    this.cues,
    this.onCueSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: cues
          .map(
            (item) => ListTile(
              key: Key(item.uid),
              onTap: () {
                _handleItemSelect(item.uid);
                Navigator.of(context).pop();
              },
              leading: ClipOval(
                child: Container(
                  // TODO: Base the color of rising/falling/tracking
                  color: Colors.blue[300],
                  height: 45,
                  width: 45,
                  child: Center(
                    child: Text(
                      _removeDecimalZeroFormat(item.lxCue.value),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              title: Text(item.who.value.toUpperCase()),
              trailing: Text(
                item.intensity.value.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item.location.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          )
          .toList(),
    );
  }

  void _handleItemSelect(String cueSelected) {
    onCueSelect(cueSelected);
  }

  // Remove the .0 on cue numbers
  String _removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
