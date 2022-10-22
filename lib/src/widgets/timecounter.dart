import 'dart:async';

import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {

  final int timeInSeconds;

  const TimeCounter({
    super.key,
    required this.timeInSeconds  
  });

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {

  late Timer counterTimer = Timer(Duration.zero, () {});
  double counterValue = 0.0;
  int counterDisplayValue = 0;

  @override
  void initState() {
    super.initState();

    counterDisplayValue = widget.timeInSeconds;
    double incrementValue = 1 / widget.timeInSeconds;

    counterTimer = Timer.periodic(const Duration(seconds: 1),
      (timer) {

        if (counterDisplayValue == 0) {
          timer.cancel();
        }
        else {
          setState(() {
            counterDisplayValue--;
            counterValue += incrementValue;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80, height: 80,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 60, height: 60,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 8,
                value: counterValue,
              ),
            ),
          ),
          Center(
            child: Text(
              '$counterDisplayValue', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)
            ),
          )
        ],
      )
    );
  }
}