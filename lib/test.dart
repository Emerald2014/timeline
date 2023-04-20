import 'package:flutter/material.dart';
import 'package:timeline/data/card_list.dart';
import 'package:timeline/model/game_card.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Drag(),
      );
}

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  int randomIndex = Random().nextInt(cardListOnHand.length);

  // List<GameCard> boardCardList = List.empty();
  List handCardList = [];
  List boardCardList = [];
  int indexOfLastCard = -1;
  bool isCardClicked = false;
  int indexOfClickedCard = -1;
  late AnimationController _controller;
  late Animation _myAnimation;

  @override
  void initState() {
    handCardList.addAll(cardListOnHand);
    boardCardList.add(handCardList[randomIndex]);
    handCardList.removeAt(randomIndex);
    handCardList.shuffle(Random());
    boardCardList.insert(0, GameCard(name: "", id: -1, year: 0));
    boardCardList.insert(
        boardCardList.length, GameCard(name: "", id: -1, year: 0));
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200), vsync: Drag,

    );
    _myAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Text("Заново"))
              ],
            ),
            if (isCardClicked)
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: 1,
                curve: Curves.easeInOutSine,
                child: openCard(context, indexOfClickedCard),
              ),
          ]),
        ),
      ),
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
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      boardCard.year.toString(),
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget openCard(BuildContext context, int index) {
    GameCard openCard = boardCardList[index];
    return Padding(
      key: Key("loading"),
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: Card(
          color: Colors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Text(openCard.name)],
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
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.grey,
        width: 40,
        height: 40,
      ),
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
    boardCardList.insert(0, GameCard(name: "", id: -1, year: 0));
    boardCardList.insert(
        boardCardList.length, GameCard(name: "", id: -1, year: 0));
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
      isTruePosition = cardFromHand.year > prevBoardCard.year &&
          cardFromHand.year < nextBoardCard.year;
    } else if (indexBoardCard == 0) {
      isTruePosition = cardFromHand.year < nextBoardCard.year;
    } else if (indexBoardCard == boardCardList.length - 2) {
      isTruePosition = cardFromHand.year > prevBoardCard.year;
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
