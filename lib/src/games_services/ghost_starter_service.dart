import 'package:flutter/material.dart';

class GhostStarterService extends ChangeNotifier {

  bool areGhostStarted = false;
  bool isTimeUp = false;

  void reset() {
    areGhostStarted = false;
    isTimeUp = false;
    notifyListeners();
  }

  void startGhosts() {
    areGhostStarted = true;
    notifyListeners();
  }

  void setTimeUp() {
    isTimeUp = true;
    notifyListeners();
  }

  void stopGhosts() {
    areGhostStarted = false;
    notifyListeners();
  }
}