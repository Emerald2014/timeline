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
    on<GameRestarted>(_onGameRestarted);
  }

  final GameRepository gameRepository;
  GameCard? currentTableCard;
  GameCard? currentHandCard;

  @override
  Future<void> close() {
    // _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> getInitialCard() async {
    try {
      gameRepository.getGameCards();
      log("gameRepository.currentCardList = ${gameRepository.currentCardList.length}");
      log("handGameCard: gameRepository.currentCardList[0] = ${gameRepository.currentCardList[0].name}");
      currentTableCard = gameRepository.currentCardList[0];
      currentHandCard = gameRepository.currentCardList[1];

      emit(state.copyWith(
          handGameCard: currentHandCard,
          tableGameCard: currentTableCard,
          gameStatus: GameStatus.runGame));
    } on Exception {}

    // emit(state.listGameCard.);
  }

  void _onCardInserted(CardInserted event, Emitter<GameState> emit) {
    // emit();
  }

  void _onCardInsertedBefore(
      CardInsertBeforePressed event, Emitter<GameState> emit) {
    log('TL _onCardInsertedBefore');
    if (compareYearCard(ChooseButton.before)) {
      emit(state.copyWith(gameRightAnswer: state.gameRightAnswer + 1));
    } else {
      emit(state.copyWith(gameWrongAnswer: state.gameWrongAnswer + 1));
    }

    gameRepository.removeCardFromList(currentTableCard!.name);
    gameRepository.removeCardFromList(currentHandCard!.name);
    if (cardListIsEmpty()) {
      emit(state.copyWith(gameStatus: GameStatus.endGame));
    } else {
      currentTableCard = gameRepository.currentCardList[0];
      currentHandCard = gameRepository.currentCardList[1];
      emit(state.copyWith(
          handGameCard: currentHandCard, tableGameCard: currentTableCard));
    }
  }

  void _onCardInsertedLater(
      CardInsertLaterPressed event, Emitter<GameState> emit) async {
    if (compareYearCard(ChooseButton.later)) {
      emit(state.copyWith(gameRightAnswer: state.gameRightAnswer + 1));
    } else {
      emit(state.copyWith(gameWrongAnswer: state.gameWrongAnswer + 1));
    }

    gameRepository.removeCardFromList(currentTableCard!.name);
    gameRepository.removeCardFromList(currentHandCard!.name);
    currentTableCard = gameRepository.currentCardList[0];
    currentHandCard = gameRepository.currentCardList[1];
    emit(state.copyWith(
        handGameCard: currentHandCard, tableGameCard: currentTableCard));
  }

  void _onGameRestarted(GameRestarted event, Emitter<GameState> emit) {
    emit(state.copyWith(
      gameStatus: GameStatus.initial,
      gameRightAnswer: 0,
      gameWrongAnswer: 0,
    ));
    gameRepository.clearCardList();
    gameRepository.getCurrentCardList();
  }

  bool compareYearCard(ChooseButton button) {
    switch (button) {
      case ChooseButton.before:
        {
          return currentHandCard!.year < currentTableCard!.year;
        }

      case ChooseButton.later:
        {
          return currentHandCard!.year > currentTableCard!.year;
        }
    }
  }

  bool cardListIsEmpty() {
    return gameRepository.currentCardList.length < 2;
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

enum ChooseButton { before, later }
