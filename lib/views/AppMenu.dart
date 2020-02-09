import 'package:flutter/material.dart';
import 'package:showpoint_spot/keys/navigatorKey.dart';
import 'package:showpoint_spot/views/Settings.dart';

class AppMenu extends StatelessWidget {
  final String currentShowName;
  final String currentShowTimeStamp;

  AppMenu({
    this.currentShowName,
    this.currentShowTimeStamp
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: (value) => _handleSelection(value, context),
        itemBuilder: (context) {
          return <PopupMenuEntry<dynamic>>[
            PopupMenuItem(
              child: Text('Server Connect'),
              value: 'server-connect',
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              child: Text('Spot Select'),
              value: 'spot-select',
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              child: Text('Settings'),
              value: 'settings',
            ),
          ];
        });
  }

void _handleSelection(dynamic value, BuildContext context) {
  switch (value) {
    case 'server-connect':
      print('SERVER CONNECT');
      break;

    case 'spot-select':
      print('SPOT SELECT');
      break;
    
    case 'settings':
      print('SETTINGS');
      //navigatorKey.currentState.push(Settings());
      Navigator.push(context, new MaterialPageRoute(
        builder: (context) => Settings(currentShowName: currentShowName, currentShowTimeStamp: currentShowTimeStamp)
      ));
      break;

    default:
      break;
  }
}

}
