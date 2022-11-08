// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_template/src/ads/ads_controller.dart';
import 'package:game_template/src/ads/banner_ad_widget.dart';
import 'package:game_template/src/games_services/games_services.dart';
import 'package:game_template/src/games_services/ghost_raid_service.dart';
import 'package:game_template/src/games_services/ghost_starter_service.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:game_template/src/games_services/scorepanel_service.dart';
import 'package:game_template/src/in_app_purchase/in_app_purchase.dart';
import 'package:game_template/src/widgets/ghostfield.dart';
import 'package:game_template/src/widgets/ghostraid.dart';
import 'package:game_template/src/widgets/scoreheader.dart';
import 'package:game_template/src/widgets/timecounter.dart';
import 'package:game_template/src/widgets/timesup.dart';
import 'package:game_template/src/widgets/whackghostcounter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    final adsControllerAvailable = context.watch<AdsController?>() != null;
    final adsRemoved =
        context.watch<InAppPurchaseController?>()?.adRemoval.active ?? false;

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
          Stack(
            children: [
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
                          padding: const EdgeInsets.all(20),
                          child: Stack(
                              children: [
                                Consumer<GhostRaidService>(
                                  builder: (context, ghostRaid, child) {
                                    return ghostRaid.showRaid ? 
                                      GhostRaid() : const SizedBox.shrink();
                                  },
                                ),
                                
                                // field of ghosts
                                GhostField(),
                                
                                // Counter
                                WhackAGhostCounter(),
                                
                                // ghost starter
                                Consumer<GhostStarterService>(
                                  builder: (context, ghostStarter, child) {
                                    return ghostStarter.isTimeUp ? 
                                    Center(
                                      child: TimesUp(
                                        onExit: () {
                                          context.read<GamesServicesController>().resetServices(context);
                                          GoRouter.of(context).pop();
                                        },
                                        onSubmitScore: () async {
                                          var totalScore = context.read<ScorePanelService>().totalScore;
                                          var s = Score.onlyScore(totalScore);

                                          await context.read<GamesServicesController>()
                                            .submitLeaderboardScore(s);

                                            GoRouter.of(context).go('/play/won', extra: {'score': s });
                                        }
                                      ) ,
                                    ) : const SizedBox.shrink();
                                  }
                                )
                              ],
                          ),
                        )
                      ),
                      const SizedBox(height: 40),
                      
                      // check if ads are available and not removed
                      adsControllerAvailable && !adsRemoved ?
                      Container(
                        color: Colors.grey,
                        child: BannerAdWidget()
                      ): SizedBox(height: 80)
                    ],
                  ),
                ),
                rectangularMenuArea: const SizedBox.shrink(),
              ),
            ],
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
