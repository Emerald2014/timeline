import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:timeline/model/models.dart';

import '../../model/game_card.dart';
import '../repository/game_repository.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required this.gameRepository}) : super(const GameState()) {
    on<CardInserted>(_onCardInserted);
    on<CardInsertBeforePressed>(_onCardInsertedBefore);
    on<CardInsertLaterPressed>(_onCardInsertedLater);
    on<GameRestarted>(_onGameRestarted);
    on<GameTypeSelected>(_onGameTypeSelected);
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
          gameStatus: GameStatus.runGame,
          totalGameCard: gameRepository.currentCardList.length));
    } on Exception {}
  }

  void _onCardInserted(CardInserted event, Emitter<GameState> emit) {}

  void _onCardInsertedBefore(
      CardInsertBeforePressed event, Emitter<GameState> emit) {
    if (compareYearCard(ChooseButton.before)) {
      emit(state.copyWith(
          gameRightAnswer: state.gameRightAnswer + 1, rightAnswer: true));
    } else {
      emit(state.copyWith(
          gameWrongAnswer: state.gameWrongAnswer + 1, rightAnswer: false));
    }
    emit(state.copyWith(previousGameCard: event.gameCard));
    if (state.gameType == GameType.thirdType) {
      if (event.gameCard != currentTableCard) {
        gameRepository.removeCardFromList(currentTableCard!.name);
      } else {
        gameRepository.removeCardFromList(currentHandCard!.name);
      }
      currentHandCard = event.gameCard;
      currentTableCard = gameRepository.currentCardList[1];
    } else {
      gameRepository.removeCardFromList(currentTableCard!.name);
      gameRepository.removeCardFromList(currentHandCard!.name);
    }

    if (cardListIsEmpty()) {
      emit(state.copyWith(gameStatus: GameStatus.endGame));
    } else {
      if (state.gameType != GameType.thirdType) {
        currentTableCard = gameRepository.currentCardList[0];
        currentHandCard = gameRepository.currentCardList[1];
        emit(state.copyWith(
            handGameCard: currentHandCard,
            tableGameCard: currentTableCard,
            playedGameCard: state.playedGameCard + 2));
      } else {
        emit(state.copyWith(
            handGameCard: currentHandCard,
            tableGameCard: currentTableCard,
            playedGameCard: state.playedGameCard + 1));
      }
    }
  }

  void _onCardInsertedLater(
      CardInsertLaterPressed event, Emitter<GameState> emit) async {
    if (compareYearCard(ChooseButton.later)) {
      emit(state.copyWith(
          gameRightAnswer: state.gameRightAnswer + 1, rightAnswer: true));
    } else {
      emit(state.copyWith(
          gameWrongAnswer: state.gameWrongAnswer + 1, rightAnswer: false));
    }
    emit(state.copyWith(previousGameCard: event.gameCard));
    if (state.gameType == GameType.thirdType) {
      if (event.gameCard != currentTableCard) {
        gameRepository.removeCardFromList(currentTableCard!.name);
      } else {
        gameRepository.removeCardFromList(currentHandCard!.name);
      }
      currentTableCard = event.gameCard;
      currentHandCard = gameRepository.currentCardList[1];
    } else {
      gameRepository.removeCardFromList(currentTableCard!.name);
      gameRepository.removeCardFromList(currentHandCard!.name);
    }

    if (cardListIsEmpty()) {
      emit(state.copyWith(gameStatus: GameStatus.endGame));
    } else {
      if (state.gameType != GameType.thirdType) {
        currentTableCard = gameRepository.currentCardList[0];
        currentHandCard = gameRepository.currentCardList[1];
        emit(state.copyWith(
            handGameCard: currentHandCard,
            tableGameCard: currentTableCard,
            playedGameCard: state.playedGameCard + 2));
      } else {
        emit(state.copyWith(
            handGameCard: currentHandCard,
            tableGameCard: currentTableCard,
            playedGameCard: state.playedGameCard + 1));
      }
    }
  }

  void _onGameRestarted(GameRestarted event, Emitter<GameState> emit) {
    emit(state.copyWith(
      gameStatus: GameStatus.initial,
      gameRightAnswer: 0,
      gameWrongAnswer: 0,
    ));
    gameRepository.clearCardList();
    gameRepository.getCurrentCardList();
    emit(state.copyWith(
        totalGameCard: gameRepository.currentCardList.length,
        playedGameCard: 0));
  }

  void _onGameTypeSelected(
      GameTypeSelected event, Emitter<GameState> emit) async {
    switch (event.gameType) {
      case GameType.firstType:
        emit(state.copyWith(gameType: GameType.firstType));
      case GameType.secondType:
        emit(state.copyWith(gameType: GameType.secondType));
      case GameType.selectedType:
      // TODO: Handle this case.
      case GameType.thirdType:
        emit(state.copyWith(gameType: GameType.thirdType));
    }
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
}

enum ChooseButton { before, later }
