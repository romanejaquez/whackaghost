import 'package:flutter/material.dart';

class GhostRaidService extends ChangeNotifier {

  bool showRaid = false;

  void triggerRaid() {
    showRaid = true;
    notifyListeners();
  }

  void reset() {
    showRaid = false;
    notifyListeners();
  }
}