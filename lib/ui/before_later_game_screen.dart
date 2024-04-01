import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/widgets/background.dart';
import '../bloc/game_bloc.dart';
import '../repository/game_repository.dart';

class BeforeLaterGameScreen extends StatelessWidget {
  const BeforeLaterGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return BeforeLaterGameScreen();
    return BlocProvider(
        create: (_) => GameBloc(gameRepository: GameRepository()),
        child: const BeforeLaterGameView());
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
          Center(child: const Actions()),
          // const GameTableView(),
          // GameHandView(),
        ],
      ),
    );
  }
}

class GameTableView extends StatelessWidget {
  const GameTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...switch (state) {
            GameInitial() => [
                ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().add(CardInsertBeforePressed());
                    },
                    child: Text("Раньше")),
                ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().add(CardInsertLaterPressed());
                    },
                    child: Text("Позже")),
              ],
            // TODO: Handle this case.
            CardInsertComplete() => throw UnimplementedError(),
            // TODO: Handle this case.
            HandIsEmpty() => throw UnimplementedError(),
          }
        ],
      );
    });
  }
}
