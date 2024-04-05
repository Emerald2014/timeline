import '../model/game_card.dart';
import '../database/card_list.dart';

class GameLocalStorageApiClient {
  GameLocalStorageApiClient();

  List<GameCard> getAllCards() {
    return cardListOnHand;
  }
}
