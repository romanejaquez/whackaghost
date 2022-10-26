import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimesUp extends StatefulWidget {
  const TimesUp({super.key});

  @override
  State<TimesUp> createState() => _TimesUpState();
}

class _TimesUpState extends State<TimesUp> with SingleTickerProviderStateMixin {
  
  late AnimationController timesUpCtrl;

  @override
  void initState() {
    super.initState();

    timesUpCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    )..forward();
  }

  @override
  void dispose() {
    timesUpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: timesUpCtrl)),
        child: ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: timesUpCtrl)),
        child: SvgPicture.asset('assets/images/timesup.svg',
          width: 200,
          height: 200,
          fit: BoxFit.contain
        ),
      ),
    );
  }
}