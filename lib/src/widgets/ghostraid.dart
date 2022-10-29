import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GhostRaid extends StatefulWidget {
  const GhostRaid({super.key});

  @override
  State<GhostRaid> createState() => _GhostRaidState();
}

class _GhostRaidState extends State<GhostRaid> with SingleTickerProviderStateMixin {

  late AnimationController ghostRaidCtrl;
  late Timer ghostRaidTimer;

  @override
  void initState() {
    super.initState();

    ghostRaidCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    ghostRaidTimer = Timer(const Duration(seconds: 3), () {
      ghostRaidCtrl.reverse();
    });
  }

  @override
  void dispose() {
    ghostRaidCtrl.dispose();
    ghostRaidTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ghostRaidCtrl.forward();

    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: ghostRaidCtrl)),
        child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.25)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: ghostRaidCtrl)),
        child: SvgPicture.asset('assets/images/ghostraid.svg')),
      )
    );
  }
}