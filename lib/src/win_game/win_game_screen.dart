// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_template/src/widgets/ghost.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../ads/ads_controller.dart';
import '../ads/banner_ad_widget.dart';
import '../games_services/score.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;

  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final adsControllerAvailable = context.watch<AdsController?>() != null;
    final adsRemoved =
        context.watch<InAppPurchaseController?>()?.adRemoval.active ?? false;
    final palette = context.watch<Palette>();
    const gap = SizedBox(height: 10);
    TextStyle defaultLabel = TextStyle(
                        color: Colors.white,
                        fontFamily: 'Grobold', fontSize: 20);

    return Scaffold(
      body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    palette.topColor,
                    palette.bottomColor
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Ghost()),
                    const SizedBox(height: 50),
                    Text('Thank you for\nsubmitting your score!',
                      style: defaultLabel.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    gap,
                    Text('Your Score: ',
                      style: defaultLabel
                    ),
                    gap,
                    Text(
                      '${score.score}',
                      style: defaultLabel.copyWith(fontSize: 50),
                    ),
                    gap,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: palette.transitionColor,
                        shape: StadiumBorder()
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Continue',
                          style: TextStyle(
                            fontFamily: 'Grobold',
                            fontSize: 20  
                          )
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
