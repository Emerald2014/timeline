import 'dart:async';

import '../model/game_card.dart';
import '../providers/game_local_storage_api_client.dart';

class GameRepository {
  GameRepository({GameLocalStorageApiClient? gameLocalStorageApiClient})
      : _gameLocalStorageApiClient =
            gameLocalStorageApiClient ?? GameLocalStorageApiClient();
  final GameLocalStorageApiClient _gameLocalStorageApiClient;

  Future<List<GameCard>> getGameCards() async {
    final cards = _gameLocalStorageApiClient.getCardsFromLocal();
    return cards;
  }
}
