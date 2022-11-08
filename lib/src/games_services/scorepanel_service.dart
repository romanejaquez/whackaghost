import 'package:flutter/material.dart';

class ScorePanelService extends ChangeNotifier {

  int numOfGhosts = 0;
  int totalScore = 0;
  int ghostValue = 100;

  void reset() {
    numOfGhosts = 0;
    totalScore = 0;
    ghostValue = 100;
    notifyListeners();
  }

  void incrementGhosts() {
    numOfGhosts++;
    notifyListeners();
  }

  void incrementScore() {
    numOfGhosts++;
    totalScore+= ghostValue;
    notifyListeners();
  }
}