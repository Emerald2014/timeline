import 'package:timeline/holiday_game/model/models.dart';

import 'holiday_mock_data.dart';

class HolidayLocalStorageApiClient {
  HolidayLocalStorageApiClient();

  List<HolidayGameCard> getCardsFromLocal() {
    return holidayCardListMock;
  }
}