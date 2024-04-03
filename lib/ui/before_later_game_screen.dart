import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/model/models.dart';

import '../../ui/widgets/background.dart';
import '../bloc/game_bloc.dart';
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
  void initState() {
    context.read<GameBloc>().getInitialCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Игра Раньше-позже")),
      body: BlocBuilder<GameBloc, GameState>(
          // listener: (context, state) {},
          builder: (context, state) {
        // if (state.gameStatus == GameStatus.initial) {
        //   context.read<GameBloc>().getInitialCard();
        // }

        if (state.gameStatus == GameStatus.endGame) {
          return EndGameView(
              gameRightAnswer: state.gameRightAnswer,
              gameWrongAnswer: state.gameWrongAnswer,
              state: state);
        } else {
          switch (state.gameType) {
            case GameType.selectedType:
              return SelectGameType();
            case GameType.firstType:
              return FirstGameType(state: state);
            case GameType.secondType:
              return SecondGameType(state: state);
          }
        }
      }),
    );
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
            ],
          ),
        )
      ],
    );
  }
}

class FirstGameType extends StatelessWidget {
  FirstGameType({super.key, required this.state});

  GameState state;

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
  SecondGameType({super.key, required this.state});

  GameState state;

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

class IsRightAnswer extends StatelessWidget {
  IsRightAnswer(this.state);

  GameState state;

  @override
  Widget build(BuildContext context) {
    return state.rightAnswer
        ? Text(
            "Верно!",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 36, color: Colors.green),
          )
        : Text("НЕ верно!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.deepOrange));
  }
}

class CardCount extends StatelessWidget {
  CardCount(
      {super.key, required this.totalGameCard, required this.playedGameCard});

  int totalGameCard;
  int playedGameCard;

  double _stepIndicator = 0;
  double _currentIndicatorPosition = 0;

  @override
  Widget build(BuildContext context) {
    _currentIndicatorPosition =
        (1 / totalGameCard * (totalGameCard - playedGameCard));

    return Column(
      children: [
        LinearProgressIndicator(
          value: _currentIndicatorPosition,
          minHeight: 20,
          color: Colors.orange,
          backgroundColor: Colors.yellowAccent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Карт осталось: ${totalGameCard - playedGameCard} / $totalGameCard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class TextQuestion extends StatelessWidget {
  TextQuestion({super.key, required this.tableCard});

  GameCard tableCard;

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
  EndGameView(
      {super.key,
      required this.gameRightAnswer,
      required this.gameWrongAnswer,
      required this.state});

  int gameRightAnswer;
  int gameWrongAnswer;
  GameState state;

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
  Score(
      {super.key,
      required this.gameRightAnswer,
      required this.gameWrongAnswer});

  int gameRightAnswer;
  int gameWrongAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Верно: $gameRightAnswer",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "Не верно: $gameWrongAnswer",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ],
    );
  }
}

class GameTableView extends StatelessWidget {
  GameTableView({required this.firstGameCard, super.key});

  GameCard firstGameCard;

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
  LeftGameCard({required this.gameCard, super.key});

  GameCard gameCard;

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
  RightGameCard({required this.gameCard, super.key});

  GameCard gameCard;

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
  GameHandView({required this.firstGameCard, super.key});

  GameCard firstGameCard;

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

class GameCardView extends StatelessWidget {
  GameCardView(
      {super.key,
      required this.gameCard,
      this.isYearVisible = false,
      this.isClickable = false,
      required this.cardPosition});

  GameCard gameCard;
  bool isYearVisible;
  bool isClickable;
  CardPosition cardPosition;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          isClickable
              ? switch (cardPosition) {
                  CardPosition.leftPosition =>
                    context.read<GameBloc>().add(CardInsertBeforePressed()),
                  CardPosition.rightPosition =>
                    context.read<GameBloc>().add(CardInsertLaterPressed()),
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
