import 'package:equatable/equatable.dart';

import '../../utils/date_converter.dart';
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

  factory GameCard.fromSql(Map<String, dynamic> sql) {
    return GameCard(
      name: sql['name'] as String,
      year: sql['year'] as int,
      date: formatDateTimeFromString(sql['date'] as String, sql['year'] as int),
      image: sql['image'] as String,
      description: sql['description'] as String,
      source: sql['source'] as String,
      author: sql['author'] as String,
      category: Category.values[sql['category_id'] as int],
      geography: Geography.values[sql['geography_id'] as int],
      level: Level.values[sql['level_id'] as int],
      century: Century.values[sql['century_id'] as int],
      id: sql['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "year": year,
      "date": date.toString(),
      "image": image,
      "description": description,
      "source": source,
      "author": author,
      "category_id": category.index,
      "geography_id": geography.index,
      "level_id": level.index,
      "century_id": century.index
    };
  }
}
