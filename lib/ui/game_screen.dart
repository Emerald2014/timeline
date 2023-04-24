import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timeline/data/card_list.dart';
import 'package:timeline/data/enums.dart';
import 'package:timeline/model/game_card.dart';
import 'package:timeline/ui/settings_screen.dart';
import 'package:timeline/ui/widgets/card_screen.dart';

class GameScreen extends StatefulWidget {
  final List<GameCard> gameCardList;

  const GameScreen({required this.gameCardList, super.key});

  @override
  _GameScreenState createState() =>
      _GameScreenState(gameCardList: gameCardList);
}

class _GameScreenState extends State<GameScreen> {
  final List<GameCard> gameCardList;

  _GameScreenState({required this.gameCardList});

  int randomIndex = 0;

  // List<GameCard> boardCardList = List.empty();
  List<GameCard> handCardList = [];
  List<GameCard> boardCardList = [];
  int indexOfLastCard = -1;
  bool isCardClicked = false;
  int indexOfClickedCard = -1;

  @override
  void initState() {
    handCardList.clear();
    if (gameCardList.isEmpty) {
      handCardList.addAll(cardListOnHand);
    } else {
      handCardList.addAll(gameCardList);
    }
    randomIndex = Random().nextInt(handCardList.length);
    boardCardList.add(handCardList[randomIndex]);
    handCardList.removeAt(randomIndex);
    handCardList.shuffle(Random());
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const GameScreen(gameCardList: [])));
                    },
                    child: Text("Заново")),
              ],
            ),
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
                    )
                  ],
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
        padding: const EdgeInsets.fromLTRB(0,0,50,0),
        child: Card(
          child: SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                handCard.name,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ),
      onDragStarted: () {
        setState(() {});
      },
      onDragCompleted: () {
        setState(() {
          removeAndAddCard();
        });
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          removeAndAddCard();
        });
      },
      onDragEnd: (DraggableDetails details) {
        setState(() {
          removeAndAddCard();
        });
      },
    );
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
            : const SizedBox(
                width: 5,
                height: 5,
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
        } else {}
      },
    );
  }
}
