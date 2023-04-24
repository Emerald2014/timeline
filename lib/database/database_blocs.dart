import 'dart:async';

import 'package:timeline/model/game_card.dart';

import 'database.dart';

class GameCardBloc {
  GameCardBloc() {
    getGameCards();
  }

  final _gameCardController = StreamController<List<GameCard>>.broadcast();

  get gameCards => _gameCardController.stream;

  getGameCards() async {
    _gameCardController.sink.add(await DBProvider.db.getAllGameCards());
  }

  dispose() {
    _gameCardController.close();
  }
}
