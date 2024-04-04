part of 'holiday_bloc.dart';

class HolidayState {
  HolidayState({
    this.holidayStatus = HolidayStatus.initial,
    this.firstGameCard,
    this.secondGameCard,
    this.gameRightAnswer = 0,
    this.gameWrongAnswer = 0,
    this.totalGameCard = 0,
    this.playedGameCard = 0,
    this.rightAnswer = false,
    this.previousGameCard,
  });

  final HolidayGameCard? firstGameCard;
  final HolidayGameCard? secondGameCard;
  final HolidayStatus holidayStatus;
  final int gameRightAnswer;
  final int gameWrongAnswer;
  final int totalGameCard;
  final int playedGameCard;
  final bool rightAnswer;
  final HolidayGameCard? previousGameCard;

  HolidayState copyWith(
      {HolidayGameCard? firstGameCard,
      HolidayGameCard? secondGameCard,
      HolidayStatus? holidayStatus,
      int? gameRightAnswer,
      int? gameWrongAnswer,
      int? totalGameCard,
      int? playedGameCard,
      bool? rightAnswer,
      HolidayGameCard? previousGameCard}) {
    return HolidayState(
      firstGameCard: firstGameCard ?? this.firstGameCard,
      secondGameCard: secondGameCard ?? this.secondGameCard,
      holidayStatus: holidayStatus ?? this.holidayStatus,
      gameRightAnswer: gameRightAnswer ?? this.gameRightAnswer,
      gameWrongAnswer: gameWrongAnswer ?? this.gameWrongAnswer,
      totalGameCard: totalGameCard ?? this.totalGameCard,
      playedGameCard: playedGameCard ?? this.playedGameCard,
      rightAnswer: rightAnswer ?? this.rightAnswer,
      previousGameCard: previousGameCard ?? this.previousGameCard,
    );
  }
}

enum HolidayStatus { initial, runGame, endGame }
