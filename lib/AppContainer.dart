import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:showpoint_spot/main.dart';
import 'package:showpoint_spot/models/AppStateModel.dart';
import 'package:showpoint_spot/models/CueModel.dart';
import 'package:showpoint_spot/models/ShowPayloadModel.dart';
import 'package:web_socket_channel/io.dart';

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  IOWebSocketChannel channel; // IP of the server machine
  AppStateModel appState; // App State Model
  String saveData; // Data that is/has been saved to local storage

  final jsonDecoder = JsonDecoder();

  @override
  void initState() {
    channel = IOWebSocketChannel.connect('ws://192.168.1.15:80');

    channel.stream.listen((payLoad) {
      if (payLoad is String) {
        // TODO: Validate JSON here. Check the ID (schema matches) what is expedted. Do the convert in a try/catch
        final payLoadModel =
            ShowPayloadModel.fromJson(jsonDecoder.convert(payLoad));
        print(payLoad);

        //If payload comes in save data to local storage
        try {
          writeContent(payLoad);
          print('Show Data Saved');
        } catch (e) {
          print('Show Data Failed to Save. Error:');
          print(e);
        }

        setState(() {
          appState = appState.copyWith(
            cues: payLoadModel.cues,
            currentShowID: payLoadModel.currentShowID,
            currentShowName: payLoadModel.currentShowName,
            currentShowTimeStamp: payLoadModel.currentShowTimeStamp,
          );
        });
      }
    });

// Init our state to default values.
    appState = AppStateModel(
        cues: <CueModel>[], currentCueID: '1', currentShowID: '-1');

    // If there is currently no cue appState then read and use the locally saved data
    // TODO: If app starts up with no data, need to request a copy from the server otherwise app errors out
    if (appState.cues.isEmpty == true) {
      readContent().then((onValue) {
        final savedPayLoad =
            ShowPayloadModel.fromJson(jsonDecoder.convert(onValue));

        setState(() {
          appState = appState.copyWith(
            cues: savedPayLoad.cues,
            currentShowID: savedPayLoad.currentShowID,
            currentShowName: savedPayLoad.currentShowName,
            currentShowTimeStamp: savedPayLoad.currentShowTimeStamp,
          );
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make this better for the perforamnce. Currently interates through all cues 3 times over before returns value
    final int currentCueIndex = appState.cues.indexWhere((item) =>
        item.uid ==
        appState.currentCueID); // Find the index of the cue we want.

    final CueModel currentCue = _currentCueIndex(
        currentCueIndex); // Now that we have the index. Extract the actual CueModel.
    final CueModel nextCue =
        _nextCueIndex(appState.cues, currentCueIndex); // And the next One
    final CueModel futureCue =
        _futureCueIndex(appState.cues, currentCueIndex); // And the next one.

    return App(
      currentCueID: appState.currentCueID,
      cues: appState.cues,
      currentCue: currentCue,
      nextCue: nextCue,
      futureCue: futureCue,
      onCueSelect: _handleCueSelect,
      currentShowName: appState.currentShowName,
      currentShowTimeStamp: appState.currentShowTimeStamp,

      // These are annonymous functions
      onNextButtonPressed: () => _gotoNextCue(currentCueIndex),
      onBackButtonPressed: () => _goBackCue(currentCueIndex),
    );
  }

  // Called when next button/gesture is activated
  void _gotoNextCue(int currentCueIndex) {
    //channel.sink.add("BLAH BLAH BALJOKSHD!");

    final newCueIndex = currentCueIndex + 1;
    final newCueID = _fetchForwardID(appState.cues, newCueIndex);

    print('Next ID: ' + newCueID.toString());

    setState(() {
      appState = appState.copyWith(
        currentCueID: newCueID,
      );
    });
  }

  // Called when the back button/gesture is activated
  void _goBackCue(int currentCueIndex) {
    final newCueIndex = currentCueIndex - 1;
    final newCueID = _fetchBackwardsID(appState.cues, newCueIndex);

    print('Back ID: ' + newCueID.toString());

    setState(() {
      appState = appState.copyWith(
        currentCueID: newCueID,
      );
    });
  }

  // Determine the next ID (and error check). Used when next button/gesture is activated. -1 returned if cue does not exist.
  String _fetchForwardID(List<CueModel> cues, int desiredIndex) {
    if (desiredIndex < cues.length && cues[desiredIndex] != null) {
      return cues[desiredIndex].uid;
    }
    return '-1';
  }

  // Determine the last ID (and error check). Used when back button/gesture is activated. -1 returned if cue does not exist.
  String _fetchBackwardsID(List<CueModel> cues, int desiredIndex) {
    if (desiredIndex >= 0 && cues[desiredIndex] != null) {
      return cues[desiredIndex].uid;
    }
    return '-1';
  }

  // Check that the current cue index exists. -1 returns null. Returns CueModel of Current cue. -1 returns null.
  CueModel _currentCueIndex(int currentCueIndex) {
    if (currentCueIndex != -1) {
      return appState.cues[currentCueIndex];
    }
    return null;
  }

  // Check that the next cue index exists. -1 returns null. Returns CueModel of Next cue. -1 returns null.
  CueModel _nextCueIndex(List<CueModel> cues, int currentCueIndex) {
    final desiredIndex = currentCueIndex + 1;

    if (currentCueIndex != -1 &&
        desiredIndex < cues.length &&
        desiredIndex != null) {
      return appState.cues[currentCueIndex + 1];
    }
    return null;
  }

  // Check that the future cue index exists. Returns CueModel of Future cue. -1 returns null.
  CueModel _futureCueIndex(List<CueModel> cues, int currentCueIndex) {
    final desiredIndex = currentCueIndex + 2;

    if (currentCueIndex != -1 &&
        desiredIndex < cues.length &&
        desiredIndex != null) {
      return appState.cues[currentCueIndex + 2];
    }
    return null;
  }

  // Set State when user selects cue to go to.
  _handleCueSelect(String cueSelected) {
    print('Go To Cue: ' + cueSelected);

    setState(() {
      appState = appState.copyWith(
        currentCueID: cueSelected,
      );
    });
  }

  // Return the folder path for local storage
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  // Return the file path
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/showName.json');
  }

  // Read locally saved cue data
  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  // Write cue data to local storage
  Future<File> writeContent(dynamic payLoad) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(payLoad);
  }
}
