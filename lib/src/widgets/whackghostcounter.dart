import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_template/src/games_services/ghost_starter_service.dart';
import 'package:provider/provider.dart';

class WhackAGhostCounter extends StatefulWidget {
  const WhackAGhostCounter({super.key});

  @override
  State<WhackAGhostCounter> createState() => _WhackAGhostCounterState();
}

class _WhackAGhostCounterState extends State<WhackAGhostCounter> with SingleTickerProviderStateMixin {
  
  late AnimationController numberCtrl;
  late Timer numberTimer = Timer(Duration.zero, () {});
  late Timer overallTimer = Timer(Duration.zero, () {});
  String imgPath = '';
  int count = 3;
  bool isCountComplete = false;

  @override
  void initState() {
    super.initState();

    numberCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );

    executeCounter(context);
  }

  void executeCounter(BuildContext context) {

    count = 3;
    isCountComplete = false;
    overallTimer.cancel();
    numberTimer.cancel();
    numberCtrl.reset();

    imgPath = 'assets/images/$count.svg';

    overallTimer = Timer(const Duration(milliseconds: 500), () {
      numberCtrl.forward();

      numberTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (count == 0) {
          timer.cancel();

          context.read<GhostStarterService>().startGhosts();
          
          setState(() {
            isCountComplete = true;
          });
        }
        else {
          setState(() {
            numberCtrl.reset();
            numberCtrl.forward();
            count--;

            if (count == 0) {
              imgPath = 'assets/images/go.svg';
            }
            else {
              imgPath = 'assets/images/$count.svg';
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    numberCtrl.dispose();
    numberTimer.cancel();
    overallTimer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return isCountComplete ? const SizedBox.shrink() : Center(
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1)
          .animate(CurvedAnimation(curve: Curves.easeInOut, parent: numberCtrl)),
          child: ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1)
          .animate(CurvedAnimation(curve: Curves.easeInOut, parent: numberCtrl)),
          child: SvgPicture.asset(imgPath,
            width: 150,
            height: 150,
            fit: BoxFit.contain
          ),
        ),
      ),
    );
  }
}