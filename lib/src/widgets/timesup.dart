import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_template/src/games_services/games_services.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:game_template/src/games_services/scorepanel_service.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:provider/provider.dart';

class TimesUp extends StatefulWidget {

  final VoidCallback onExit;
  final VoidCallback onSubmitScore;

  const TimesUp({
    super.key,
    required this.onExit,
    required this.onSubmitScore  
  });

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
    final palette = context.read<Palette>();
    final bool hasValidScore = context.read<ScorePanelService>().totalScore > 0;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FadeTransition(
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
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: hasValidScore,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: palette.transitionColor,
              shape: StadiumBorder()
            ),
            onPressed: widget.onSubmitScore,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Submit Score',
                style: TextStyle(
                  fontFamily: 'Grobold',
                  fontSize: 20  
                )
              ),
            )
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.transitionColor,
            shape: StadiumBorder()
          ),
          onPressed: widget.onExit,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Exit Game',
              style: TextStyle(
                fontFamily: 'Grobold',
                fontSize: 20  
              )
            ),
          )
        )
      ],
    );
  }
}