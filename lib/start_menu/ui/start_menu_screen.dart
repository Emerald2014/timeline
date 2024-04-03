import 'package:flutter/material.dart';
import 'package:timeline/holiday_game/ui/holiday_game_screen.dart';

import '../../dual_game_classic/ui/before_later_game_screen.dart';
import '../../ui/game_screen.dart';
import '../../ui/widgets/background.dart';

class StartMenuScreen extends StatelessWidget {
  const StartMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StartMenuView();
  }
}

class StartMenuView extends StatelessWidget {
  const StartMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Линия времени"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const GameScreen(gameCardList: [])));
                    },
                    child: const Text("Классическая игра")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BeforeLaterGameScreen()));
                    },
                    child: const Text("Игра \"Раньше-позже\"")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HolidayGameScreen()));
                    },
                    child: const Text("Игра \"Праздники\"")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
