import 'package:equatable/equatable.dart';

import 'enums.dart';

class GameCard extends Equatable {
  final String name;
  final int year;
  final DateTime? date;
  final String image;
  final String description;
  final String source;
  final String author;
  final Category category;
  final Geography geography;
  final Level level;
  final Century century;
  final int id;

//Main constructor
  const GameCard(
      {required this.name,
      required this.year,
      this.date,
      this.image = "assets/no_image.jpg",
      this.description = "",
      this.source = "",
      this.author = "",
      this.category = Category.all,
      this.geography = Geography.allWorld,
      this.level = Level.hard,
      this.century = Century.all,
      this.id = 0});

  @override
  List<Object?> get props => [
        name,
        year,
        date,
        image,
        description,
        source,
        author,
        category,
        geography,
        level,
        century,
        id
      ];
  static GameCard empty = const GameCard(
      name: '', year: -1, category: Category.all, century: Century.XXI);
}
