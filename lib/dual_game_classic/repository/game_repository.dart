import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:timeline/dual_game_classic/providers/db_providers.dart';

import '../model/game_card.dart';
import '../providers/game_local_storage_api_client.dart';

class GameRepository {
  GameRepository(

    // DBProvider? gameDBProvider
    // GameLocalStorageApiClient? gameLocalStorageApiClient
  )    ;
      // :
      //   _gameDBProvider= gameDBProvider?? DBProvider();
        // _gameLocalStorageApiClient =
        //     gameLocalStorageApiClient ?? GameLocalStorageApiClient()


  // final GameLocalStorageApiClient _gameLocalStorageApiClient;
  // final DBProvider _gameDBProvider;


  Future<dynamic> getGameCards2({required Database database}) async {
    final data = await database.rawQuery('SELECT * FROM game_card');
    List<GameCard> gameCards = [];
    log("test $data");
    // for (var item in data) {
    //   gameCards.add(GameCard(name: item['name'], year: item['name']))
    // }
  }




  final _gameDBProvider = DBProvider();
  // final Database database ;

  List<GameCard> currentCardList = [];
  final List<GameCard> _currentFullCardList = [];

  Future<void> getGameCards() async {
    // _currentFullCardList.addAll(_gameLocalStorageApiClient.getAllCards());
    // _gameDBProvider.getInit();
    // log("db = ${_gameDBProvider.db2}");
    // log("db tables = ${_gameDBProvider.getAllTables().toString()}");
    // _gameDBProvider.getAllTableNames().then((value) => {log("tables name = $value")});
    // log("db tables name = ${_gameDBProvider.getAllTableNames().toString()}");
    // _gameDBProvider.getGameCards(database: database);
    _currentFullCardList.addAll(_gameDBProvider.getAllCards());
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
