import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/model/enums.dart';

import '../../ui/widgets/background.dart';
import '../bloc/game_bloc.dart';
import '../model/game_card.dart';
import '../repository/game_repository.dart';

class BeforeLaterGameScreen extends StatelessWidget {
  const BeforeLaterGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return BeforeLaterGameScreen();
    return BlocProvider(
        create: (context) => GameBloc(gameRepository: GameRepository()),
        // create: (context) => GameBloc(gameRepository: context.read<GameRepository>()),
        child: BeforeLaterGameView());
  }
}

class BeforeLaterGameView extends StatefulWidget {
  const BeforeLaterGameView({super.key});

  @override
  State<BeforeLaterGameView> createState() => _BeforeLaterGameViewState();
}

class _BeforeLaterGameViewState extends State<BeforeLaterGameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Игра Раньше-позже"),
      ),
      body: BlocBuilder<GameBloc, GameState>(
          // listener: (context, state) {},
          builder: (context, state) {
        context.read<GameBloc>().getInitialCard();
        final firstTableCard = state.tableGameCard ??
            GameCard(
                name: "name",
                year: -1,
                category: Category.events,
                century: Century.XXI);
        final firstHandCard = state.handGameCard ??
            GameCard(
                name: "name",
                year: -1,
                category: Category.events,
                century: Century.XXI);
        return Stack(
          children: [
            const Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GameTableView(firstGameCard: firstTableCard),
                Center(child: const Actions()),
                GameHandView(firstGameCard: firstHandCard),
              ],
            )

            // GameHandView(),
          ],
        );
      }),
    );
  }
}

class GameTableView extends StatelessWidget {
  GameTableView({required this.firstGameCard, super.key});

  GameCard firstGameCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [card(firstGameCard)],
    );
  }
}

class GameHandView extends StatelessWidget {
  GameHandView({required this.firstGameCard, super.key});

  GameCard firstGameCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [card(firstGameCard)],
    );
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
      );
    });
  }
}

Widget card(GameCard gameCard) {
  return Center(
    child: Card(
      child: SizedBox(
        width: 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  gameCard.name,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                gameCard.year.toString(),
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                gameCard.image,
                height: 70,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
