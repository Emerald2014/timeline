part of 'game_bloc.dart';

sealed class GameState {
  const GameState();
}

final class GameInitial extends GameState {
  const GameInitial();
}

final class CardInsertComplete extends GameState {
  const CardInsertComplete();
}

final class HandIsEmpty extends GameState {
  const HandIsEmpty() : super();
}
