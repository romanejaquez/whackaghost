import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScoreHeader extends StatelessWidget {

  Widget? centerWidget;
  ScoreHeader({
    super.key,
    this.centerWidget  
  });

  @override
  Widget build(BuildContext context) {
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
                  Text('3', style: TextStyle(
                    fontSize: 40,
                    color: Colors.white)
                  )
                ],
              ),
              Text('250', style: TextStyle(
                fontSize: 40,
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
}