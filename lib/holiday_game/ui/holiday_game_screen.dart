import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/holiday_game/bloc/holiday_bloc.dart';
import 'package:timeline/holiday_game/repository/holiday_repository.dart';
import 'package:timeline/holiday_game/ui/widgets/game_card_view.dart';
import 'package:timeline/holiday_game/ui/widgets/widgets.dart';

import '../../ui/widgets/background.dart';

class HolidayGameScreen extends StatelessWidget {
  const HolidayGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayBloc(HolidayRepository()),
      child: const HolidayGameView(),
    );
  }
}

class HolidayGameView extends StatefulWidget {
  const HolidayGameView({super.key});

  @override
  State<StatefulWidget> createState() => _HolidayGameViewState();
}

class _HolidayGameViewState extends State<HolidayGameView> {
  @override
  void initState() {
    context.read<HolidayBloc>().add(GameInitialized());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Игра Праздники"),
      ),
      body: BlocBuilder<HolidayBloc, HolidayState>(builder: (context, state) {
        if (state.holidayStatus == HolidayStatus.endGame) {
          return EndGameView(
              gameRightAnswer: state.gameRightAnswer,
              gameWrongAnswer: state.gameWrongAnswer,
              state: state);
        } else {
          return HolidayGame(state: state);
        }
      }),
    );
  }
}

class HolidayGame extends StatelessWidget {
  const HolidayGame({super.key, required this.state});

  final HolidayState state;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CardCount(
                  totalGameCard: state.totalGameCard,
                  playedGameCard: state.playedGameCard,
                ),
                Score(
                    gameRightAnswer: state.gameRightAnswer,
                    gameWrongAnswer: state.gameWrongAnswer),
              ],
            ),
            if (state.playedGameCard != 0) IsRightAnswer(state),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Что раньше?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GameCardView(gameCard: state.firstGameCard!),
                    const Text(
                      "ИЛИ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GameCardView(gameCard: state.secondGameCard!)
                  ],
                )
              ],
            ),
            const SizedBox(),
          ],
        ),
      )
    ]);
  }
}
