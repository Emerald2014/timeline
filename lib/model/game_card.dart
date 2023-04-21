import 'package:flutter/cupertino.dart';
import '../data/enums.dart';

class GameCard {
  final String name;
  final int year;
  late final DateTime? date;
  late final AssetImage? image;
  late final String description;
  late final String source;
  late final String author;
  late final Category category;
  late final Geography geography;
  late final Level level;
  late final Century century;
  late final int id;

//Main constructor
  GameCard(
      {required this.name,
      required this.year,
      this.date,
      this.image = const AssetImage("assets/no_image.jpg"),
      this.description = "",
      this.source = "",
      this.author = "",
      this.category = Category.allCategory,
      this.geography = Geography.allWorld,
      this.level = Level.hard,
      this.century = Century.allTime,
      this.id = 0});
}
