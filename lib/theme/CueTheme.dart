import 'package:flutter/material.dart';
import 'package:showpoint_spot/models/CueThemeModel.dart';


class CueTheme extends InheritedWidget {
final CueThemeModel data;

   CueTheme({
      Key key,
      @required Widget child,
      this.data,
   }): super(key: key, child: child);
		
   static CueTheme of(BuildContext context) {
      return context.dependOnInheritedWidgetOfExactType();
   }

   @override
   bool updateShouldNotify(CueTheme oldWidget) => data != oldWidget.data;
}