import 'package:flutter/material.dart';

class ScorePanelService extends ChangeNotifier {

  int numOfGhosts = 0;
  int totalScore = 0;
  int ghostValue = 100;

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