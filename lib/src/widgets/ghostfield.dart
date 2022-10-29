import 'package:flutter/material.dart';
import 'package:game_template/src/widgets/whackghost.dart';

class GhostField extends StatelessWidget {
  const GhostField({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: WhackGhost()
        ),
        Align(
          alignment: Alignment.topLeft,
          child: WhackGhost()
        ),
        Align(
          alignment: Alignment.topRight,
          child: WhackGhost()
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: WhackGhost()
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: WhackGhost()
        ),
      ],
    );
  }
}