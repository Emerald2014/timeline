import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/game_card.dart';

class GameRepository {
  GameRepository();

  List<GameCard> currentCardList = [];
  final List<GameCard> _currentFullCardList = [];

  Future<void> getGameCards2({required Database database}) async {
    final data = await database.rawQuery('SELECT * FROM game_card');
    for (var item in data) {
      _currentFullCardList.add(GameCard.fromSql(item));
    }
    _currentFullCardList.toSet();
    getCurrentCardList();
  }

  void getCurrentCardList() {
    currentCardList.addAll(_currentFullCardList);
    currentCardList.shuffle();
  }

  void removeCardFromList(String name) {
    currentCardList.removeWhere((item) => item.name == name);
  }

  void clearCardList() {
    currentCardList.clear();
  }
}
