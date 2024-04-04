import 'package:timeline/holiday_game/model/models.dart';

import '../providers/holiday_local_storage_api_client.dart';

class HolidayRepository {
  HolidayRepository(
      {HolidayLocalStorageApiClient? holidayLocalStorageApiClient})
      : _holidayLocalStorageApiClient =
            holidayLocalStorageApiClient ?? HolidayLocalStorageApiClient();
  final HolidayLocalStorageApiClient _holidayLocalStorageApiClient;

  List<HolidayGameCard> currentCardList = [];
  final List<HolidayGameCard> _currentFullCardList = [];

  Future<void> getGameCards() async {
    _currentFullCardList
        .addAll(_holidayLocalStorageApiClient.getCardsFromLocal());
    getCurrentCardList();
  }

  void getCurrentCardList() {
    currentCardList.clear();
    currentCardList.addAll(_currentFullCardList);
    currentCardList.shuffle();
  }

  void removeCardFromList(String name) {
    currentCardList.removeWhere((item) => item.name == name);
  }

  void clearCardList() {
    currentCardList.clear();
  }
}
