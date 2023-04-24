import 'dart:convert';

import '../data/enums.dart';

class GameCard {
  final String name;
  final int year;
  late final DateTime? date;
  late final String image;
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
      this.image = "assets/no_image.jpg",
      this.description = "",
      this.source = "",
      this.author = "",
      required this.category,
      this.geography = Geography.allWorld,
      this.level = Level.hard,
      required this.century,
      this.id = 0});

  factory GameCard.fromMap(Map<String, dynamic> json) => GameCard(
      name: json["name"],
      year: json["year"],
      date: json["date"],
      image: json["image"],
      description: json["description"],
      source: json["source"],
      author: json["author"],
      category: json["category"],
      geography: json["geography"],
      century: json["century"],
      id: json["id"]);

  Map<String, dynamic> toMap() => {
        "name": name,
        "year": year,
        "date": date,
        "image": image,
        "description": description,
        "source": source,
        "author": author,
        "category": category,
        "geography": geography,
        "century": century,
        "id": id
      };
}

GameCard gameCardFromJson(String str) {
  final jsonData = json.decode(str);
  return GameCard.fromMap(jsonData);
}

String gameCardToJson(GameCard data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
