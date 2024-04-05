import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timeline/dual_game_classic/database/database.dart';
import 'package:timeline/dual_game_classic/model/game_card.dart';

import '../database/card_list.dart';

class DBProvider {
  // DBProvider(Database? dbInit): _dbInit = dbInit?.database?? DBInit().database;
  // Database _dbInit;

  Future<dynamic> getGameCards({required Database database}) async {
    final data = await database.rawQuery('SELECT * FROM game_card');
    List<GameCard> gameCards = [];
    log("test $data");
    // for (var item in data) {
    //   gameCards.add(GameCard(name: item['name'], year: item['name']))
    // }
  }
  List<GameCard> getAllCards() {
    return cardListOnHand;
  }
}