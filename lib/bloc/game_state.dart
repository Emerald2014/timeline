part of 'game_bloc.dart';

class GameState {
  const GameState({
    this.tableGameCard,
    this.handGameCard,
    this.gameStatus = GameStatus.initial,
    this.gameRightAnswer = 0,
    this.gameWrongAnswer = 0,
  });

  final GameCard? tableGameCard;
  final GameCard? handGameCard;
  final GameStatus gameStatus;
  final int gameRightAnswer;
  final int gameWrongAnswer;

  GameState copyWith({
    GameCard? tableGameCard,
    GameCard? handGameCard,
    GameStatus? gameStatus,
    int? gameRightAnswer,
    int? gameWrongAnswer,
  }) {
    return GameState(
        tableGameCard: tableGameCard ?? this.tableGameCard,
        handGameCard: handGameCard ?? this.handGameCard,
        gameStatus: gameStatus ?? this.gameStatus,
        gameRightAnswer: gameRightAnswer ?? this.gameRightAnswer,
        gameWrongAnswer: gameWrongAnswer ?? this.gameWrongAnswer);
  }
}

enum GameStatus { initial, runGame, endGame }
