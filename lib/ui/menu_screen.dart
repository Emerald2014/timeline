import 'package:flutter/material.dart';
import 'package:timeline/ui/game_screen.dart';

import 'before_later_game_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GameScreen(gameCardList: [])));
                },
                child: Text("Классическая игра")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BeforeLaterGameScreen()));
                },
                child: Text("Игра \"Раньше-позже\"")),
          ],
        ),
      ),
    );
  }
}
