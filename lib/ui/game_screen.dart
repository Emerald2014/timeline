import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timeline/data/card_list.dart';
import 'package:timeline/data/enums.dart';
import 'package:timeline/model/game_card.dart';
import 'package:timeline/ui/settings_screen.dart';
import 'package:timeline/ui/widgets/card_screen.dart';
import 'package:timeline/ui/widgets/deck_of_cards.dart';

class GameScreen extends StatefulWidget {
  final List<GameCard> gameCardList;

  const GameScreen({required this.gameCardList, super.key});

  @override
  _GameScreenState createState() =>
      _GameScreenState(gameCardList: gameCardList);
}

class _GameScreenState extends State<GameScreen> {
  final List<GameCard> gameCardList;
  final VoidCallback myVoidCallback = () {};

  _GameScreenState({required this.gameCardList});

  int randomIndex = 0;
  List<GameCard> handCardList = [];
  List<GameCard> deckOfCard = [];
  List<GameCard> boardCardList = [];
  int indexOfLastCard = -1;
  bool isCardClicked = false;
  int indexOfClickedCard = -1;
  bool isVisibleCardPreview = false;
  int indexOfClickedCardForHelp = -1;
  var colorSeparator;

  @override
  void initState() {
    deckOfCard.clear();
    if (gameCardList.isEmpty) {
      deckOfCard.addAll(cardListOnHand);
    } else {
      deckOfCard.addAll(gameCardList);
    }
    randomIndex = Random().nextInt(deckOfCard.length);
    boardCardList.add(deckOfCard[randomIndex]);
    deckOfCard.removeAt(randomIndex);
    deckOfCard.shuffle(Random());
    for (var i = 0; i < 5; i++) {
      handCardList.add(deckOfCard[i]);
      deckOfCard.removeAt(i);
    }
    boardCardList.insert(
        0,
        GameCard(
            name: "",
            id: -1,
            year: 0,
            category: Category.inventions,
            century: Century.earlier));
    boardCardList.insert(
        boardCardList.length,
        GameCard(
            name: "",
            id: -1,
            year: 0,
            category: Category.inventions,
            century: Century.earlier));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[200],
      body: GestureDetector(
        onTap: () {
          setState(() {
            isCardClicked = false;
          });
        },
        child: SafeArea(
          child: Stack(children: [
            Column(
              children: [
                Text("Игровой стол"),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: Expanded(
                        child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: listBoardCard,
                        separatorBuilder: _buildDragTargetsBoard,
                        itemCount: boardCardList.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )),
                  ),
                ),
//            list view separated will build a widget between 2 list items to act as a separator
                Text("Рука игрока"),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: _buildListHandCard,
                  // separatorBuilder: _buildDragTargetsA,
                  itemCount: handCardList.length,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        isVisibleCardPreview = true;
                      },
                      child: Text("Подсказка"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const GameScreen(gameCardList: [])));
                        },
                        child: Text("Заново")),
                    Visibility(
                      visible: false,
                      child: ElevatedButton(onPressed: () {}, child: Text("")),
                    ),
                  ],
                ),
              ],
            ),
            deckOfCards(context, deckOfCard.length, callback),
            if (isCardClicked)
              openCard(context, indexOfClickedCard, boardCardList),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SettingScreen()));
        },
        child: Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget listBoardCard(BuildContext context, int index) {
    GameCard boardCard = boardCardList[index];

    return boardCardList[index].id == -1
        ? Container()
        : GestureDetector(
            onTap: () {
              setState(() {
                isCardClicked = true;
                indexOfClickedCard = index;
              });
            },
            child: Card(
              color: indexOfLastCard == index
                  ? Colors.lightGreenAccent
                  : Colors.white,
              child: SizedBox(
                width: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          boardCard.name,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        boardCard.year.toString(),
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        boardCard.image,
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

//  builds the widgets for List A items
  Widget _buildListHandCard(BuildContext context, int index) {
    GameCard handCard = handCardList[index];

    return Draggable<String>(
      data: handCard.name,
      feedback: Card(
        child: SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              handCard.name,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.grey,
        width: 40,
        height: 40,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
        child: GestureDetector(
          onTap: () {
            if (isVisibleCardPreview) {
              setState(() {
                isVisibleCardPreview = false;
                indexOfClickedCardForHelp = index;
              });
            } else {
              print("Tap on card $index");
            }
          },
          child: Card(
            child: SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        handCard.name,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Visibility(
                        child: Text(
                          handCard.year.toString(),
                        ),
                        visible: checkVisibility(index))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onDragStarted: () {
        setState(() {
          colorSeparator = Colors.blueAccent;
        });
      },
      onDragCompleted: () {
        setState(() {
          removeAndAddCard();
          colorSeparator = null;
        });
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          removeAndAddCard();
          colorSeparator = null;
        });
      },
      onDragEnd: (DraggableDetails details) {
        setState(() {
          removeAndAddCard();
          colorSeparator = null;
        });
      },
    );
  }

  bool checkVisibility(int index) {
    return (indexOfClickedCardForHelp == index);
  }

  void removeAndAddCard() {
    boardCardList.removeWhere((item) => item.id == -1);
    boardCardList.insert(
        0,
        GameCard(
            name: "",
            id: -1,
            year: 0,
            category: Category.inventions,
            century: Century.earlier));
    boardCardList.insert(
        boardCardList.length,
        GameCard(
            name: "",
            id: -1,
            year: 0,
            category: Category.inventions,
            century: Century.earlier));
  }

  Widget _buildDropPreview(BuildContext context, String value) {
    return Card(
      color: Colors.redAccent[200],
      child: SizedBox(
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 8),
          ),
        ),
      ),
    );
  }

  bool compareYear(int indexBoardCard, GameCard cardFromHand) {
    bool isTruePosition = true;
    GameCard prevBoardCard = boardCardList[indexBoardCard];
    GameCard nextBoardCard = boardCardList[indexBoardCard + 1];

    if (indexBoardCard > 0 && indexBoardCard < boardCardList.length - 2) {
      isTruePosition = cardFromHand.year >= prevBoardCard.year &&
          cardFromHand.year <= nextBoardCard.year;
    } else if (indexBoardCard == 0) {
      isTruePosition = cardFromHand.year <= nextBoardCard.year;
    } else if (indexBoardCard == boardCardList.length - 2) {
      isTruePosition = cardFromHand.year >= prevBoardCard.year;
    } else {
      false;
    }
    return isTruePosition;
  }

  Widget _buildDragTargetsBoard(BuildContext context, int index) {
    return DragTarget<String>(
      builder: (context, candidates, rejects) {
        return candidates.isNotEmpty
            ? _buildDropPreview(context, candidates[0]!)
            : Container(
                width: 5,
                height: 5,
                color: colorSeparator,
              );
      },
      onWillAccept: (value) => !boardCardList.contains(value),
      onAccept: (value) {
        GameCard item = boardCardList[0];

        for (var i in handCardList) {
          if (value == i.name) {
            item = i;
          }
        }
        if (compareYear(index, item)) {
          setState(() {
            boardCardList.insert(index + 1, item);
            handCardList.removeWhere((item) => item.name == value);
            indexOfLastCard = index + 1;
          });
        } else {
          setState(() {
            handCardList.add(deckOfCard[0]);
            deckOfCard.removeAt(0);
          });
        }
      },
    );
  }

  callback() {
    setState(() {
      handCardList.add(deckOfCard[0]);
      deckOfCard.removeAt(0);
    });
  }
}
