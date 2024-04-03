import 'dart:async';

import '../model/game_card.dart';
import '../providers/game_local_storage_api_client.dart';

class GameRepository {
  GameRepository({GameLocalStorageApiClient? gameLocalStorageApiClient})
      : _gameLocalStorageApiClient =
            gameLocalStorageApiClient ?? GameLocalStorageApiClient();
  final GameLocalStorageApiClient _gameLocalStorageApiClient;

  List<GameCard> currentCardList = [];
  final List<GameCard> _currentFullCardList = [];

  Future<void> getGameCards() async {
    _currentFullCardList.addAll(_gameLocalStorageApiClient.getCardsFromLocal());
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
