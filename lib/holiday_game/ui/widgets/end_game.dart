import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/holiday_game/bloc/holiday_bloc.dart';

import '../../../ui/widgets/background.dart';

class EndGameView extends StatelessWidget {
  const EndGameView(
      {super.key,
      required this.gameRightAnswer,
      required this.gameWrongAnswer,
      required this.state});

  final int gameRightAnswer;
  final int gameWrongAnswer;
  final HolidayState state;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Игра окончена",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text("Ваш счет:"),
            Text((gameRightAnswer - gameWrongAnswer).toString()),
            ElevatedButton(
                onPressed: () {
                  context.read<HolidayBloc>().add(GameRestarted());
                },
                child: const Text("Заново?"))
          ],
        ),
      ),
    ]);
  }
}
