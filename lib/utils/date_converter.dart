import 'dart:developer';

DateTime formatDateTimeFromString(String stringDate, int year) {
  DateTime dateTime;
  try {
    dateTime = DateTime.parse(stringDate);
  } catch (e) {
    dateTime = DateTime(year);
  }
  log("Converted Date = $dateTime");
  return dateTime;
}
