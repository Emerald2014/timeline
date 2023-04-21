import 'package:flutter/material.dart';
import 'package:timeline/model/game_card.dart';

Widget openCard(BuildContext context, int index, List<GameCard> boardCardList) {
  GameCard openCard = boardCardList[index];
  return Padding(
    key: Key("loading"),
    padding: const EdgeInsets.all(50.0),
    child: Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(openCard.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text(openCard.year.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    ),
  );
}
