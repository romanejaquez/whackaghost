import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_template/src/widgets/ghost.dart';

class WhackGhost extends StatefulWidget {
  const WhackGhost({super.key});

  @override
  State<WhackGhost> createState() => _WhackGhostState();
}

class _WhackGhostState extends State<WhackGhost> with SingleTickerProviderStateMixin {

  double initValue = -100;
  double endValue = 50;
  int duration = 0;
  int delay = 0;
  bool isEndOfAnimation = false;
  late Timer delayTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    randomizeDuration();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void randomizeDuration() {
    duration = Random().nextInt(500) + 250;
    //duration = Random().nextInt(250) + 50;
  }

  void randomizeDelay() {
    delay = Random().nextInt(750) + 250;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 100,
      child: Stack(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: SvgPicture.asset('./assets/images/ghost_shadow.svg')
                      ),
                    ],
                  )
                ),
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 200,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      TweenAnimationBuilder<double>(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: duration),
                        tween: Tween<double>(begin: initValue, end: endValue),
                        onEnd: () {
                          
                          randomizeDelay();

                          delayTimer = Timer(Duration(milliseconds: delay), () {
                            setState(() {

                              isEndOfAnimation = !isEndOfAnimation;

                              var temp = endValue;
                              endValue = initValue;
                              initValue = temp;

                              if (!isEndOfAnimation) {
                                randomizeDuration();
                              }
                            });
                          });
                        },
                        builder: (context, value, widget) {
                          return Positioned(
                            bottom: value,
                            child: Ghost(),
                          );
                        }
                      )
                    ],
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}