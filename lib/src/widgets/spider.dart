import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Spider extends StatefulWidget {
  const Spider({super.key});

  @override
  State<Spider> createState() => _SpiderState();
}

class _SpiderState extends State<Spider> with SingleTickerProviderStateMixin {
  
  late AnimationController spiderCtrl;

  @override
  void initState() {
    super.initState();

    spiderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100)
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    spiderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80, height: 80,
      child: Stack(
        children: [
          Center(
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.025, end: -0.025
              ).animate(CurvedAnimation(parent: spiderCtrl, curve: Curves.easeInOut)),
              child: SvgPicture.asset('assets/images/spiderlegs.svg')
            )
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset('assets/images/spiderbody.svg'),
            )
          )
        ],
      ),
    );
  }
}