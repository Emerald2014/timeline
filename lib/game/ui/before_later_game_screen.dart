import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/widgets/background.dart';
import '../bloc/game_bloc.dart';

class BeforeLaterGameScreen extends StatelessWidget {
  const BeforeLaterGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GameBloc(), child: const BeforeLaterGameView());
  }
}

class BeforeLaterGameView extends StatelessWidget {
  const BeforeLaterGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Игра Раньше-позже"),
      ),
      body: Stack(
        children: [
          const Background(),
          const GameTableView(),
          // GameHandView(),
        ],
      ),
    );
  }
}

class GameTableView extends StatelessWidget{
  const GameTableView({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold();
  }
}
