// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_template/src/ads/ads_controller.dart';
import 'package:game_template/src/common/gamehomebutton.dart';
import 'package:game_template/src/in_app_purchase/in_app_purchase.dart';
import 'package:game_template/src/widgets/ghost.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();

  static const _gap = SizedBox(height: 10);
}

class _MainMenuScreenState extends State<MainMenuScreen> with SingleTickerProviderStateMixin {

  late AnimationController ghostAnim;

  @override
  void initState() {
    super.initState();

    ghostAnim = AnimationController(vsync: this,
      duration: const Duration(seconds: 1)
    )..repeat(reverse: true);

    // Preload ad for the game screen.
    final adsRemoved =
        context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    if (!adsRemoved) {
      final adsController = context.read<AdsController?>();
      adsController?.preloadAd();
    }
  }

  @override
  void dispose() {
    ghostAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final palette = context.read<Palette>();
    final settingsController = context.watch<SettingsController>();
    final gamesServicesController = context.watch<GamesServicesController?>();

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
          // menu
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Center(child: SvgPicture.asset('./assets/images/logo_noghost.svg')),
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, -0.09),
                            end: Offset(0, 0.09)
                          ).animate(CurvedAnimation(parent: ghostAnim, curve: Curves.easeInOut)),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 40, top: 35),
                              child: Ghost()
                            )
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),

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
                        gamesServicesController!.showLeaderboard();
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
}
