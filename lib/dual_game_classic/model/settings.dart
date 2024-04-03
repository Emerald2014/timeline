import 'enums.dart';

class Settings {
  final List<Category> category;
  late final Geography geography;
  late final Level level;
  final List<Century> century;

  Settings({
    required this.category,
    this.geography = Geography.allWorld,
    this.level = Level.hard,
    required this.century,
  });
}
