part of 'game_bloc.dart';

class GameState {
  const GameState(
      {this.tableGameCard,
      this.handGameCard,
      this.gameStatus = GameStatus.initial,
      this.gameType = GameType.selectedType,
      this.gameRightAnswer = 0,
      this.gameWrongAnswer = 0,
      this.totalGameCard = 0,
      this.playedGameCard = 0,
      this.rightAnswer = false});

  final GameCard? tableGameCard;
  final GameCard? handGameCard;
  final GameStatus gameStatus;
  final GameType gameType;
  final int gameRightAnswer;
  final int gameWrongAnswer;
  final int totalGameCard;
  final int playedGameCard;
  final bool rightAnswer;

  GameState copyWith(
      {GameCard? tableGameCard,
      GameCard? handGameCard,
      GameStatus? gameStatus,
      GameType? gameType,
      int? gameRightAnswer,
      int? gameWrongAnswer,
      int? totalGameCard,
      int? playedGameCard,
      bool? rightAnswer}) {
    return GameState(
      tableGameCard: tableGameCard ?? this.tableGameCard,
      handGameCard: handGameCard ?? this.handGameCard,
      gameStatus: gameStatus ?? this.gameStatus,
      gameType: gameType ?? this.gameType,
      gameRightAnswer: gameRightAnswer ?? this.gameRightAnswer,
      gameWrongAnswer: gameWrongAnswer ?? this.gameWrongAnswer,
      totalGameCard: totalGameCard ?? this.totalGameCard,
      playedGameCard: playedGameCard ?? this.playedGameCard,
      rightAnswer: rightAnswer ?? this.rightAnswer,
    );
  }
}

enum GameStatus { initial, runGame, endGame }

enum GameType { selectedType, firstType, secondType }
