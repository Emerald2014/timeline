import 'dart:async';

import '../model/game_card.dart';
import '../providers/game_local_storage_api_client.dart';

class GameRepository {
  GameRepository({GameLocalStorageApiClient? gameLocalStorageApiClient})
      : _gameLocalStorageApiClient =
            gameLocalStorageApiClient ?? GameLocalStorageApiClient();
  final GameLocalStorageApiClient _gameLocalStorageApiClient;

  List<GameCard> currentCardList = [];

  Future<void> getGameCards() async {
    currentCardList = _gameLocalStorageApiClient.getCardsFromLocal();
    currentCardList.shuffle();
  }

  void removeCardFromList(String name) {
    currentCardList.removeWhere((item) => item.name == name);
  }
}
