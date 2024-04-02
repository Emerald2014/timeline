part of 'game_bloc.dart';

class GameState {
  const GameState(
      {this.tableGameCard,
      this.handGameCard,
      this.gameStatus = GameStatus.initial});

  final GameCard? tableGameCard;
  final GameCard? handGameCard;
  final GameStatus gameStatus;

  GameState copyWith(
      {GameCard? tableGameCard,
      GameCard? handGameCard,
      GameStatus? gameStatus}) {
    return GameState(
        tableGameCard: tableGameCard ?? this.tableGameCard,
        handGameCard: handGameCard ?? this.handGameCard,
        gameStatus: gameStatus ?? this.gameStatus);
  }
}

enum GameStatus { initial, endGame }
