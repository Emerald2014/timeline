import 'package:flutter/material.dart';

import '../../ui/before_later_game_screen.dart';
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
                          builder: (context) => BeforeLaterGameScreen()));
                    },
                    child: const Text("Игра \"Раньше-позже\"")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
