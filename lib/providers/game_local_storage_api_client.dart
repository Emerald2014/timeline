import '../model/game_card.dart';
import 'card_list.dart';

class GameLocalStorageApiClient {
  GameLocalStorageApiClient();

  List<GameCard> getCardsFromLocal() {
    return cardListOnHand;
  }
}
