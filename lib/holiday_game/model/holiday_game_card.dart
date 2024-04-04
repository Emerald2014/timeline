class HolidayGameCard {
  const HolidayGameCard({
    this.source = "",
    this.description = "",
    this.holidayCategory = HolidayCategory.all,
    this.holidayGeography = HolidayGeography.all,
    this.isMutable = false,
    this.numberDayInYear = -1,
    required this.date,
    required this.name,
  });

  final String name;
  final bool isMutable;
  final int numberDayInYear;
  final DateTime date;
  final HolidayCategory holidayCategory;
  final HolidayGeography holidayGeography;
  final String description;
  final String source;
}

enum HolidayCategory {
  politic,
  public,
  religious,
  corporate,
  private,
  combat,
  all
}

enum HolidayGeography { russia, world, all }
