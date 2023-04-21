import '../data/enums.dart';

class Settings {
  late final Category category;
  late final Geography geography;
  late final Level level;
  late final Century century;

  Settings({
    this.category = Category.allCategory,
    this.geography = Geography.allWorld,
    this.level = Level.hard,
    this.century = Century.allTime,
  });
}
