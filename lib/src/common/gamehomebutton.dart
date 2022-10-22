import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameHomeButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap;

  const GameHomeButton({super.key,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(40),
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50, right: 50, top: 20, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/arrow.svg',
                width: 30, height: 30,
              ),
              const SizedBox(width: 10),
              Text(label,
                style: TextStyle(fontSize: 25)
              ),
            ],
          ),
        )
      ),
    );
  }
}