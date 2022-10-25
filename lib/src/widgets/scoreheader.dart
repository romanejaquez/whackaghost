import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_template/src/games_services/scorepanel_service.dart';
import 'package:provider/provider.dart';

class ScoreHeader extends StatelessWidget {

  Widget? centerWidget;
  ScoreHeader({
    super.key,
    this.centerWidget  
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ScorePanelService>(
      builder: (context, scoreService, child) {
        return SizedBox(
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('./assets/images/tiny_ghost.svg'),
                      const SizedBox(width: 10),
                      Text('${scoreService.numOfGhosts}', style: TextStyle(
                        fontSize: 30,
                        color: Colors.white)
                      )
                    ],
                  ),
                  Text('${scoreService.totalScore}', style: TextStyle(
                    fontSize: 30,
                    color: Colors.white)
                  )
                ],
              ),
              Center(
                child: centerWidget ?? const SizedBox.shrink(),
              )
            ],
          ),
        );
      }
    );
  }
}