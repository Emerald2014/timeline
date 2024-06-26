class CustomDateFormatter {
  const CustomDateFormatter();

  String getFullMonth(DateTime date) {
    String month = switch (date.month) {
      1 => "января",
      2 => "февраля",
      3 => "марта",
      4 => "апреля",
      5 => "мая",
      6 => "июня",
      7 => "июля",
      8 => "августа",
      9 => "сентября",
      10 => "октября",
      11 => "ноября",
      12 => "декабря",
      int() => throw UnimplementedError(),
    };
    return "${date.day} $month";
  }
}
