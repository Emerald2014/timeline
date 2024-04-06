import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/widgets/background.dart';
import '../bloc/database_bloc.dart';
import '../bloc/database_state.dart';
import '../bloc/game_bloc.dart';
import '../model/models.dart';

class BeforeLaterGameScreen extends StatelessWidget {
  const BeforeLaterGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc()..initDatabase()),
    ], child: const BeforeLaterGameView());
  }
}

class BeforeLaterGameView extends StatefulWidget {
  const BeforeLaterGameView({super.key});

  @override
  State<BeforeLaterGameView> createState() => _BeforeLaterGameViewState();
}

class _BeforeLaterGameViewState extends State<BeforeLaterGameView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Игра Раньше-позже")),
        body: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            if (state is LoadDatabaseState) {
              final gameBloc =
                  GameBloc(database: context.read<DatabaseBloc>().database!);
              return BlocProvider<GameBloc>(
                  create: (context) => gameBloc,
                  child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                    if (state.gameStatus == GameStatus.initial) {
                      context.read<GameBloc>().add(GameInitialized());
                    }
                    if (state.gameStatus == GameStatus.loadingDatabase) {
                      // context.read<GameBloc>().add(GameRestarted());
                      log("GameStatus.loadingDatabase");

                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.gameStatus == GameStatus.endGame) {
                      return EndGameView(
                          gameRightAnswer: state.gameRightAnswer,
                          gameWrongAnswer: state.gameWrongAnswer,
                          state: state);
                    } else {
                      switch (state.gameType) {
                        case GameType.selectedType:
                          return const SelectGameType();
                        case GameType.firstType:
                          return FirstGameType(state: state);
                        case GameType.secondType:
                          return SecondGameType(state: state);
                        case GameType.thirdType:
                          return ThirdGameType(state: state);
                      }
                    }
                  }));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class SelectGameType extends StatelessWidget {
  const SelectGameType({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<GameBloc>()
                        .add(GameTypeSelected(gameType: GameType.firstType));
                  },
                  child: const Text("Первый тип игры")),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<GameBloc>()
                        .add(GameTypeSelected(gameType: GameType.secondType));
                  },
                  child: const Text("Второй тип игры")),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<GameBloc>()
                        .add(GameTypeSelected(gameType: GameType.thirdType));
                  },
                  child: const Text("Третий тип игры")),
            ],
          ),
        )
      ],
    );
  }
}

class FirstGameType extends StatelessWidget {
  const FirstGameType({super.key, required this.state});

  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardCount(
              totalGameCard: state.totalGameCard,
              playedGameCard: state.playedGameCard,
            ),
            Score(
                gameRightAnswer: state.gameRightAnswer,
                gameWrongAnswer: state.gameWrongAnswer),
            GameHandView(
                firstGameCard: state.handGameCard ??
                    GameCard(
                        name: "name",
                        year: -2,
                        category: Category.events,
                        century: Century.XXI)),
            TextQuestion(tableCard: state.tableGameCard!),
            const Center(child: Actions()),
            Divider(),
            GameTableView(
                firstGameCard: state.tableGameCard ??
                    GameCard(
                        name: "name",
                        year: -2,
                        category: Category.events,
                        century: Century.XXI)),
          ],
        )
      ],
    );
  }
}

class SecondGameType extends StatelessWidget {
  const SecondGameType({super.key, required this.state});

  final GameState state;

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
                Text(
                  "Что раньше?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LeftGameCard(gameCard: state.handGameCard!),
                    Text(
                      "ИЛИ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RightGameCard(gameCard: state.tableGameCard!)
                  ],
                )
              ],
            ),
            SizedBox(),
          ],
        ),
      )
    ]);
  }
}

class ThirdGameType extends StatelessWidget {
  const ThirdGameType({super.key, required this.state});

  final GameState state;

  @override
  Widget build(BuildContext context) {
    log("state ThirdGameType = $state");
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
                Text(
                  "Что раньше?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LeftGameCard(gameCard: state.handGameCard!),
                    Text(
                      "ИЛИ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    RightGameCard(gameCard: state.tableGameCard!)
                  ],
                )
              ],
            ),
            SizedBox(),
          ],
        ),
      )
    ]);
  }
}

class IsRightAnswer extends StatelessWidget {
  const IsRightAnswer(this.state, {super.key});

  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.rightAnswer
            ? Text(
                "Верно!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.green),
              )
            : Text("НЕ верно!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.deepOrange)),
        Text(
          "${state.previousGameCard!.name} (${state.previousGameCard!.year})",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class CardCount extends StatelessWidget {
  const CardCount(
      {super.key, required this.totalGameCard, required this.playedGameCard});

  final int totalGameCard;
  final int playedGameCard;

  @override
  Widget build(BuildContext context) {
    double currentIndicatorPosition =
        1 - (1 / totalGameCard * (totalGameCard - playedGameCard));

    return Stack(
      children: [
        LinearProgressIndicator(
          value: currentIndicatorPosition,
          minHeight: 24,
          color: Colors.orange,
          backgroundColor: Colors.yellowAccent,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        Center(
          child: Text(
            "Прогресс: ${playedGameCard} / $totalGameCard",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class TextQuestion extends StatelessWidget {
  const TextQuestion({super.key, required this.tableCard});

  final GameCard tableCard;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Это событие произошло раньше или позже, чем \n',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: "${tableCard.name} (${tableCard.year})?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          // TextSpan(text: '?'),
        ],
      ),
    );
  }
}

class EndGameView extends StatelessWidget {
  const EndGameView(
      {super.key,
      required this.gameRightAnswer,
      required this.gameWrongAnswer,
      required this.state});

  final int gameRightAnswer;
  final int gameWrongAnswer;
  final GameState state;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Игра окончена",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text("Ваш счет:"),
            Text((gameRightAnswer - gameWrongAnswer).toString()),
            ElevatedButton(
                onPressed: () {
                  context.read<GameBloc>().add(GameRestarted());
                },
                child: Text("Заново?"))
          ],
        ),
      ),
    ]);
  }
}

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.gameRightAnswer,
      required this.gameWrongAnswer});

  final int gameRightAnswer;
  final int gameWrongAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: "Ответы: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: gameRightAnswer.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green),
              ),
              TextSpan(text: " / "),
              TextSpan(
                text: gameWrongAnswer.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
              ),
              // TextSpan(text: '?'),
            ],
          ),
        ),
      ],
    );
  }
}

class GameTableView extends StatelessWidget {
  const GameTableView({required this.firstGameCard, super.key});

  final GameCard firstGameCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GameCardView(
          gameCard: firstGameCard,
          cardPosition: CardPosition.unknown,
          isYearVisible: true,
        )
      ],
    );
  }
}

class LeftGameCard extends StatelessWidget {
  const LeftGameCard({required this.gameCard, super.key});

  final GameCard gameCard;

  @override
  Widget build(BuildContext context) {
    return GameCardView(
      gameCard: gameCard,
      cardPosition: CardPosition.leftPosition,
      isClickable: true,
    );
  }
}

class RightGameCard extends StatelessWidget {
  const RightGameCard({required this.gameCard, super.key});

  final GameCard gameCard;

  @override
  Widget build(BuildContext context) {
    return GameCardView(
      gameCard: gameCard,
      cardPosition: CardPosition.rightPosition,
      isClickable: true,
    );
  }
}

class GameHandView extends StatelessWidget {
  const GameHandView({required this.firstGameCard, super.key});

  final GameCard firstGameCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GameCardView(
          gameCard: firstGameCard,
          cardPosition: CardPosition.unknown,
        )
      ],
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
                context.read<GameBloc>().add(CardInsertBeforePressed(null));
              },
              child: Text("Раньше")),
          ElevatedButton(
              onPressed: () {
                context.read<GameBloc>().add(CardInsertLaterPressed(null));
              },
              child: Text("Позже")),
        ],
      );
    });
  }
}

class GameCardView extends StatelessWidget {
  const GameCardView(
      {super.key,
      required this.gameCard,
      this.isYearVisible = false,
      this.isClickable = false,
      required this.cardPosition});

  final GameCard gameCard;
  final bool isYearVisible;
  final bool isClickable;
  final CardPosition cardPosition;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          isClickable
              ? switch (cardPosition) {
                  CardPosition.leftPosition => context
                      .read<GameBloc>()
                      .add(CardInsertBeforePressed(gameCard)),
                  CardPosition.rightPosition => context
                      .read<GameBloc>()
                      .add(CardInsertLaterPressed(gameCard)),
                  CardPosition.unknown => throw UnimplementedError(),
                }
              : {};
        },
        child: Card(
          child: SizedBox(
            width: 150,
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
                  isYearVisible
                      ? Text(
                          gameCard.year.toString(),
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        )
                      : Text(""),
                  Image.asset(
                    gameCard.image,
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CardPosition { leftPosition, rightPosition, unknown }
