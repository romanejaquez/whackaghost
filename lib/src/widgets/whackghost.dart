import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_template/src/games_services/ghost_starter_service.dart';
import 'package:game_template/src/games_services/scorepanel_service.dart';
import 'package:game_template/src/widgets/ghost.dart';
import 'package:provider/provider.dart';

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
  bool isGhostKilled = false;
  late AnimationController scoreAnim;

  @override
  void initState() {
    super.initState();

    scoreAnim = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    randomizeDuration();
  }

  @override
  void dispose() {
    if (mounted) {
      delayTimer.cancel();
    }
    super.dispose();
  }

  void randomizeDuration() {
    //duration = Random().nextInt(500) + 250;
    duration = Random().nextInt(250) + 150;
  }

  void resetGhostValues() {
    if (mounted) {
      setState(() {
        initValue = 50;
        endValue = -100;
        duration = 0;
        isGhostKilled = true;
      });

      Future.delayed(const Duration(milliseconds: 500),() {
        setState(() {
          scoreAnim.reset();
          randomizeDuration();
          initValue = -100;
          endValue = 50;
          isGhostKilled = false;
          isEndOfAnimation = false;
        });
      });
    }
  }

  void randomizeDelay() {
    delay = Random().nextInt(500) + 150;
    //delay = Random().nextInt(750) + 250;
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

              // ghost shadow
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

              // ghost listener
              Consumer<GhostStarterService>(
                builder: (context, ghostStarter, child) {
                  
                  return ghostStarter.areGhostStarted ? 
                    Center(
                      child: Container(
                        width: 100,
                        height: 200,
                        color: Colors.transparent,
                        child: Builder(
                          builder: (context) {

                            // when ghost killed, run the score animation
                            if (isGhostKilled) {

                              scoreAnim.forward();
                              return Center(
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset.zero,
                                    end: Offset(0, -1)
                                  )
                                  .animate(CurvedAnimation(parent: scoreAnim, curve: Curves.easeOut)),
                                  child: SvgPicture.asset('assets/images/100pt.svg',
                                    width: 35, height: 35
                                  )
                                )
                              );
                            }

                            return Stack(
                              children: [
                                TweenAnimationBuilder<double>(
                                  curve: Curves.easeInOut,
                                  duration: Duration(milliseconds: duration),
                                  tween: Tween<double>(begin: initValue, end: endValue),
                                  onEnd: () {
                                    
                                    randomizeDelay();
                                    delayTimer = Timer(Duration(milliseconds: delay), () {
                                      
                                      if (mounted) {
                                        setState(() {
                                          isEndOfAnimation = !isEndOfAnimation;

                                          var temp = endValue;
                                          endValue = initValue;
                                          initValue = temp;

                                          if (!isEndOfAnimation) {
                                            randomizeDuration();
                                          }
                                        });
                                      }
                                    });
                                  },
                                  builder: (context, value, widget) {

                                    return Positioned(
                                      bottom: value,
                                      child: Ghost(
                                        onWhackGhost: () {
                                          
                                          context.read<ScorePanelService>().incrementScore();
                                          resetGhostValues();
                                          //throw StateError('tapping on a ghost');
                                        }
                                      )
                                    );
                                  }
                                )
                              ],
                            );
                          }
                        )
                      ),
                    ) : 
                    const SizedBox.shrink();
                },
              )
              
            ],
          )
        ],
      ),
    );
  }
}