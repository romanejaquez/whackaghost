import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_template/src/common/spidermodel.dart';

class SpiderGenerator extends ChangeNotifier {

  bool areSpidersReleased = false;

  List<SpiderModel> spiders = [];

  void releaseSpiders(BuildContext context) {

    Random randomSpiders = Random();
    var numOfSpiders = 100;
    var screeWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var spiderWidth = 80;
    var posValue = screeWidth / 2; // (screeWidth / spiderWidth) + spiderWidth / 2;

    for(var i = 0; i < numOfSpiders; i++) {

      double sSpeed = Random().nextInt(1) + 5;
      var sPos = (Random().nextInt(posValue.toInt() + 1 ));
      spiders.add(SpiderModel(
        speed: Random().nextInt(5).toDouble() + 2, 
        xPosition: sPos.toDouble(),
        y1Position: spiderWidth * -1,
        y2Position: 11, //(screenHeight / spiderWidth).toDouble()
      ));
    }

    areSpidersReleased = true;
  }
}