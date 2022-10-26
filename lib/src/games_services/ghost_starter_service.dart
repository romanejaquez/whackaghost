import 'package:flutter/material.dart';

class GhostStarterService extends ChangeNotifier {

  bool areGhostStarted = false;
  bool isTimeUp = false;

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