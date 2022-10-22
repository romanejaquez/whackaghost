// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_template/src/common/gamehomebutton.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final palette = context.read<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

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
          Center(
            child: SvgPicture.asset('./assets/images/logo.svg'),
          ),

          // menu
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GameHomeButton(
                      label: 'PLAY',
                      onTap: () {
                        GoRouter.of(context).go('/play');
                      }
                    ),
                    const SizedBox(height: 20),

                    GameHomeButton(
                      label: 'LEADERBOARDS',
                      onTap: () {
                        
                      }
                    ),
                    const SizedBox(height: 20),

                    GameHomeButton(
                      label: 'SETTINGS',
                      onTap: () {
                        GoRouter.of(context).go('/settings');
                      }
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: settingsController.muted,
                        builder: (context, muted, child) {
                          return IconButton(
                            onPressed: () => settingsController.toggleMuted(),
                            icon: Icon(muted ? Icons.volume_off : Icons.volume_up, size: 30),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final palette = context.watch<Palette>();
  //   final gamesServicesController = context.watch<GamesServicesController?>();
  //   final settingsController = context.watch<SettingsController>();
  //   final audioController = context.watch<AudioController>();

  //   return Scaffold(
  //     backgroundColor: palette.backgroundMain,
  //     body: ResponsiveScreen(
  //       mainAreaProminence: 0.45,
  //       squarishMainArea: Center(
  //         child: Transform.rotate(
  //           angle: -0.1,
  //           child: const Text(
  //             'Flutter Game Template!',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontFamily: 'Permanent Marker',
  //               fontSize: 55,
  //               height: 1,
  //             ),
  //           ),
  //         ),
  //       ),
  //       rectangularMenuArea: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () {
  //               audioController.playSfx(SfxType.buttonTap);
  //               GoRouter.of(context).go('/play');
  //             },
  //             child: const Text('Play'),
  //           ),
  //           _gap,
  //           if (gamesServicesController != null) ...[
  //             _hideUntilReady(
  //               ready: gamesServicesController.signedIn,
  //               child: ElevatedButton(
  //                 onPressed: () => gamesServicesController.showAchievements(),
  //                 child: const Text('Achievements'),
  //               ),
  //             ),
  //             _gap,
  //             _hideUntilReady(
  //               ready: gamesServicesController.signedIn,
  //               child: ElevatedButton(
  //                 onPressed: () => gamesServicesController.showLeaderboard(),
  //                 child: const Text('Leaderboard'),
  //               ),
  //             ),
  //             _gap,
  //           ],
  //           ElevatedButton(
  //             onPressed: () => GoRouter.of(context).go('/settings'),
  //             child: const Text('Settings'),
  //           ),
  //           _gap,
  //           Padding(
  //             padding: const EdgeInsets.only(top: 32),
  //             child: ValueListenableBuilder<bool>(
  //               valueListenable: settingsController.muted,
  //               builder: (context, muted, child) {
  //                 return IconButton(
  //                   onPressed: () => settingsController.toggleMuted(),
  //                   icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
  //                 );
  //               },
  //             ),
  //           ),
  //           _gap,
  //           const Text('Music by Mr Smith'),
  //           _gap,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 10);
}
