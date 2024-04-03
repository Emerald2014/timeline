import '../providers/holiday_local_storage_api_client.dart';

class HolidayRepository {
  HolidayRepository(
      {HolidayLocalStorageApiClient? holidayLocalStorageApiClient})
      : _holidayLocalStorageApiClient =
            holidayLocalStorageApiClient ?? HolidayLocalStorageApiClient();
  final HolidayLocalStorageApiClient _holidayLocalStorageApiClient;
}
