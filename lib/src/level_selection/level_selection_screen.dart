// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_template/src/widgets/ghost.dart';
import 'package:game_template/src/widgets/scoreheader.dart';
import 'package:game_template/src/widgets/timecounter.dart';
import 'package:game_template/src/widgets/whackghost.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:widget_mask/widget_mask.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

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
          ResponsiveScreen(
            squarishMainArea: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ScoreHeader(
                    centerWidget: TimeCounter(
                      timeInSeconds: 30,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Stack(
                        children: [
                          Center(child: WhackGhost()),
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
                      ),
                    )
                  ),
                  const SizedBox(height: 40),
                  Container(
                    color: Colors.grey,
                    height: 80,
                  )
                ],
              ),
            ),
            rectangularMenuArea: const SizedBox.shrink(),
          )
        ],
      ),
    );
    /*
    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Select level',
                  style:
                      TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      enabled: playerProgress.highestLevelReached >=
                          level.number - 1,
                      onTap: () {
                        final audioController = context.read<AudioController>();
                        audioController.playSfx(SfxType.buttonTap);

                        GoRouter.of(context)
                            .go('/play/session/${level.number}');
                      },
                      leading: Text(level.number.toString()),
                      title: Text('Level #${level.number}'),
                    )
                ],
              ),
            ),
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('Back'),
        ),
      ),
    );*/
  }
}
