import 'package:flutter/material.dart';
import 'package:timeline/ui/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: GameScreen(gameCardList: []),
      );
}
