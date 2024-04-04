import 'package:bloc/bloc.dart';
import 'package:timeline/holiday_game/model/models.dart';

import '../repository/holiday_repository.dart';

part 'holiday_event.dart';

part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  HolidayBloc(this.holidayRepository) : super(HolidayState()) {
    on<GameRestarted>(_onGameRestarted);
    on<HolidayCardPressed>(_onHolidayCardPressed);
    on<GameInitialized>(_onGameInitialized);
  }

  final HolidayRepository holidayRepository;
  HolidayGameCard? firstGameCard;
  HolidayGameCard? secondGameCard;

  void _onGameRestarted(GameRestarted event, Emitter<HolidayState> emit) {
    emit(state.copyWith(
      holidayStatus: HolidayStatus.runGame,
      gameRightAnswer: 0,
      gameWrongAnswer: 0,
    ));
    holidayRepository.clearCardList();
    holidayRepository.getCurrentCardList();
    firstGameCard = holidayRepository.currentCardList[0];
    secondGameCard = holidayRepository.currentCardList[1];
    emit(state.copyWith(
        secondGameCard: secondGameCard,
        firstGameCard: firstGameCard,
        holidayStatus: HolidayStatus.runGame,
        playedGameCard: 0,
        totalGameCard: holidayRepository.currentCardList.length));
  }

  void _onHolidayCardPressed(
      HolidayCardPressed event, Emitter<HolidayState> emit) {
    if ((compareDate() && event.cardPressed == firstGameCard) ||
        (!compareDate() && event.cardPressed == secondGameCard)) {
      emit(state.copyWith(
          gameRightAnswer: state.gameRightAnswer + 1, rightAnswer: true));
    } else {
      emit(state.copyWith(
          gameWrongAnswer: state.gameWrongAnswer + 1, rightAnswer: false));
    }
    emit(state.copyWith(previousGameCard: event.cardPressed));
    if (event.cardPressed != firstGameCard) {
      holidayRepository.removeCardFromList(firstGameCard!.name);
    } else {
      holidayRepository.removeCardFromList(secondGameCard!.name);
    }
    if (cardListIsEmpty()) {
      emit(state.copyWith(holidayStatus: HolidayStatus.endGame));
    } else {
      secondGameCard = event.cardPressed;
      firstGameCard = holidayRepository.currentCardList[1];
      emit(state.copyWith(
          secondGameCard: secondGameCard,
          firstGameCard: firstGameCard,
          playedGameCard: state.playedGameCard + 1));
    }
  }

  void _onGameInitialized(GameInitialized event, Emitter<HolidayState> emit) {
    holidayRepository.getGameCards();
    firstGameCard = holidayRepository.currentCardList[0];
    secondGameCard = holidayRepository.currentCardList[1];

    emit(state.copyWith(
        secondGameCard: secondGameCard,
        firstGameCard: firstGameCard,
        holidayStatus: HolidayStatus.runGame,
        totalGameCard: holidayRepository.currentCardList.length));
  }

  bool compareDate() {
    return getNumberDayInYear(firstGameCard!.date) <
        getNumberDayInYear(secondGameCard!.date);
  }

  bool cardListIsEmpty() {
    return holidayRepository.currentCardList.length < 2;
  }

  int getNumberDayInYear(DateTime date) {
    DateTime dayInCurrentYear =
        DateTime(DateTime.now().year, date.month, date.day);
    return dayInCurrentYear
            .difference(DateTime(DateTime.now().year, 01, 01))
            .inDays +
        1;
  }
}
