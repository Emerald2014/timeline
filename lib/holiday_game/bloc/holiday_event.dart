part of 'holiday_bloc.dart';

sealed class HolidayEvent {
  const HolidayEvent();
}

final class GameRestarted extends HolidayEvent {
  GameRestarted();
}

final class HolidayCardPressed extends HolidayEvent {
  HolidayCardPressed(this.cardPressed);

  HolidayGameCard cardPressed;
}

final class GameInitialized extends HolidayEvent {
  GameInitialized();
}
