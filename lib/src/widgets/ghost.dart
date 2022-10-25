import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Ghost extends StatefulWidget {
  const Ghost({super.key});

  @override
  State<Ghost> createState() => _GhostState();
}

class _GhostState extends State<Ghost> {

  late Timer blinkTimer = Timer(Duration.zero, () {});
  late Timer blinkTimer2 = Timer(Duration.zero, () {});
  String blinkOn = 'ghost_eyes_open.svg';
  String blinkOff = 'ghost_eyes_shut.svg';
  String blink = '';

  @override
  void initState() {
    super.initState();

    blink = './assets/images/$blinkOn';
    blinkTimer = Timer.periodic(const Duration(milliseconds: 750), (timer) {

      setState(() {
        blink = './assets/images/$blinkOff';
      });

      blinkTimer2 = Timer(const Duration(milliseconds: 250), () {
        setState(() {
          blink = './assets/images/$blinkOn';
        });
      });
    });
  }
  
  @override
  void dispose() {
    if (mounted) {
      blinkTimer.cancel();
      blinkTimer2.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            color: Colors.transparent
          ),
          Center(child: SvgPicture.asset('./assets/images/ghost_body.svg')),
          Center(child: SvgPicture.asset(blink))
        ],
      ),
    );
  }
}