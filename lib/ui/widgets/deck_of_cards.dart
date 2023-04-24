import 'package:flutter/material.dart';

Widget deckOfCards(BuildContext context, int countOfCardInDeck) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 10, 0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 100,
          child: Stack(
            children: [
              Center(child: Image.asset("assets/deckOfCards.jpg")),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    countOfCardInDeck.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
