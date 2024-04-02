import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../model/game_card.dart';
import '../repository/game_repository.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // StreamSubscription<int>? _tickerSubscription;
// static  GameCard initialCard = _gam;
  GameBloc({required this.gameRepository}) : super(GameState()) {
    on<CardInserted>(_onCardInserted);
    on<CardInsertBeforePressed>(_onCardInsertedBefore);
    on<CardInsertLaterPressed>(_onCardInsertedLater);
  }

  final GameRepository gameRepository;

  @override
  Future<void> close() {
    // _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> getInitialCard() async {
    try {
      final initTableCard = await gameRepository.getGameCards();
      emit(state.copyWith(
          handGameCard: initTableCard[0], tableGameCard: initTableCard[1]));
    } on Exception {}

    var initialCard = await _tryGetGameCards();
    // emit(state.listGameCard.);
  }

  void _onCardInserted(CardInserted event, Emitter<GameState> emit) {
    // emit();
  }

  void _onCardInsertedBefore(
      CardInsertBeforePressed event, Emitter<GameState> emit) {
    log('TL _onCardInsertedBefore');
  }

  Future<void> _onCardInsertedLater(
      CardInsertLaterPressed event, Emitter<GameState> emit) async {
    log('TL _onCardInsertedLater');
    final listGameCard = await _tryGetGameCards();
    log('TL listGameCard = ${listGameCard?.length} ');
  }

  Future<List<GameCard>?> _tryGetGameCards() async {
    try {
      var localGameRepository = await gameRepository.getGameCards();
      return localGameRepository;
    } catch (_) {}
  }

// bool compareYear(int indexBoardCard, GameCard cardFromHand) {
//   bool isTruePosition = true;
//   GameCard prevBoardCard = boardCardList[indexBoardCard];
//   GameCard nextBoardCard = boardCardList[indexBoardCard + 1];
//
//   if (indexBoardCard > 0 && indexBoardCard < boardCardList.length - 2) {
//     isTruePosition = cardFromHand.year >= prevBoardCard.year &&
//         cardFromHand.year <= nextBoardCard.year;
//   } else if (indexBoardCard == 0) {
//     isTruePosition = cardFromHand.year <= nextBoardCard.year;
//   } else if (indexBoardCard == boardCardList.length - 2) {
//     isTruePosition = cardFromHand.year >= prevBoardCard.year;
//   } else {
//     false;
//   }
//   return isTruePosition;
// }
}
