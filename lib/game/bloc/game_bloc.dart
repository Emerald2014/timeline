import 'dart:async';

import 'package:bloc/bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {

  // StreamSubscription<int>? _tickerSubscription;

  GameBloc() : super(const GameInitial()) {
    on<CardInserted>(_onCardInserted);
  }

  @override
  Future<void> close() {
    // _tickerSubscription?.cancel();
    return super.close();
  }

  void _onCardInserted(CardInserted event, Emitter<GameState> emit) {
    // emit();
  }
}

class GameEvent {}

class GameState {
  const GameState();
}
