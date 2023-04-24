import 'package:flutter/material.dart';

Widget deckOfCards(BuildContext context, int countOfCardInDeck,
    void Function() myVoidCallback) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 100, 10, 0),
      child: GestureDetector(
        onTap: () {
          myVoidCallback();
        },
        child: Container(
          width: 100,
          child: Stack(
            children: [
              Center(child: Image.asset("assets/deckOfCards.jpg")),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    myVoidCallback();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    countOfCardInDeck.toString(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      myVoidCallback();
                    },
                    child: Text("Добавить"),
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
