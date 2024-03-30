part of 'game_bloc.dart';

sealed class GameEvent {
  const GameEvent();
}

final class CardInserted extends GameEvent {
  CardInserted({required this.cardInsertPosition});

  final int cardInsertPosition;
}
