import 'package:flutter/material.dart';

import '../../dual_game_classic/model/game_card.dart';


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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(openCard.name,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text(openCard.year.toString(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Image.asset(openCard.image as String),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Категория: "),
                    Text(openCard.category.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Век: "),
                    Text(openCard.century.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Автор: "),
                    Text(openCard.author,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(openCard.description.toString(),
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Источник: "),
                    Flexible(
                      child: Text(openCard.source.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
