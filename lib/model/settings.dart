import '../data/enums.dart';

class Settings {
  final List<String> category;
  late final Geography geography;
  late final Level level;
  final List<String> century;

  Settings({
    required this.category,
    this.geography = Geography.allWorld,
    this.level = Level.hard,
    required this.century,
  });
}