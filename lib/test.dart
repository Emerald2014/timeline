import 'package:flutter/material.dart';
import 'package:timeline/data/card_list.dart';
import 'package:timeline/model/game_card.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(
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
  List handCardList = cardListOnHand;
  List boardCardList = [];

  @override
  void initState() {
boardCardList.add(handCardList[randomIndex]);
handCardList.removeAt(randomIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[200],
      body: SafeArea(
        child: Column(
          children: [
            Text("Игровой стол"),
            SizedBox(
              height: 150,
              child: Expanded(
                  child: ListView.separated(
                    itemBuilder: listBoardCard,
                    separatorBuilder: _buildDragTargetsBoard,
                    itemCount: boardCardList.length,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
//            list view separated will build a widget between 2 list items to act as a separator
            Text("Рука игрока"),
            Expanded(
                child: ListView.builder(
                  itemBuilder: _buildListHandCard,
                  // separatorBuilder: _buildDragTargetsA,
                  itemCount: handCardList.length,
                )),
          ],
        ),
      ),
    );
  }

  Widget listBoardCard(BuildContext context, int index) {
    GameCard boardCard = boardCardList[index];

    return boardCardList[index].id == -1
        ? Container(
      // color: Colors.orangeAccent,
      // width: 50,
      // height: 50,
    )
        : Card(
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                boardCard.name,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Text(
              boardCard.year.toString(),
              style: TextStyle(fontSize: 8),
            )
          ],
        ),
      ),
    );
  }

//  builds the widgets for List A items
  Widget _buildListHandCard(BuildContext context, int index) {
    GameCard handCard = handCardList[index];
    GameCard item = boardCardList[0];

    for (var i in handCardList) {
      if (0 == i.id) {
        item = i;
      }
    }
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
        final snackBar = SnackBar(
          content: Text(
            'Выбрана карта ${handCard.name}',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          boardCardList.insert(0, GameCard(name: "", id: -1, year: 0));
          boardCardList.insert(
              boardCardList.length, GameCard(name: "", id: -1, year: 0));
        });
      },
      onDragCompleted: () {
        setState(() {
          boardCardList.removeWhere((item) => item.id == -1);
        });
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          boardCardList.removeWhere((item) => item.id == -1);
        });
      },
      onDragEnd: (DraggableDetails details) {
        setState(() {
          boardCardList.removeWhere((item) => item.id == -1);
        });
      },
    );
  }

//  will return a widget used as an indicator for the drop position
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

/*
//  builds DragTargets used as separators between list items/widgets for list A
  Widget _buildDragTargetsA(BuildContext context, int index) {
    return DragTarget<GameCard>(
//      builder responsible to build a widget based on whether there is an item being dropped or not
      builder: (context, candidates, rejects) {
        return candidates.length > 0
            ? _buildDropPreview(context, candidates[0]!.name)
            : Container(
                width: 5,
                height: 5,
              );
      },
//      condition on to accept the item or not
//       onWillAccept: (value) => !listA.contains(value),
//      what to do when an item is accepted
      onAccept: (value) {
        if (compareYear(index, value)) {
          print("YES");
          // setState(() {
          //   boardCardList.insert(index + 1, value);
          //   handCardList.remove(value);
          // });
        } else {
          print("No");
        }
      },
    );
  }*/

  bool compareYear(int indexBoardCard, GameCard cardFromHand) {
    bool isTruePosition = true;
    GameCard prevBoardCard = boardCardList[indexBoardCard];
    GameCard nextBoardCard = boardCardList[indexBoardCard + 1];
    print("prevBoardCard = ${prevBoardCard.year}");
    print("nextBoardCard = ${nextBoardCard.year}");
    print("myCard = ${cardFromHand.year}");
    print("length = ${boardCardList.length}");
    print("index = ${indexBoardCard}");



    if (indexBoardCard > 0 && indexBoardCard < boardCardList.length-2) {
      print("first IF");
      isTruePosition = cardFromHand.year > prevBoardCard.year &&
          cardFromHand.year < nextBoardCard.year;
    } else if (indexBoardCard == 0) {
      print("Second IF");

      isTruePosition = cardFromHand.year < nextBoardCard.year;
    } else if (indexBoardCard == boardCardList.length-2) {
      print("Third IF");

      isTruePosition = cardFromHand.year > prevBoardCard.year;
    } else {
      false;
    }
    return isTruePosition;
  }

//  builds drag targets for list B
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
        print("length = ${boardCardList.length}");
        print("index = ${index}");
        if (compareYear(index, item)) {
          print("YES");
          setState(() {
            boardCardList.insert(index + 1, item);
            handCardList.remove(item);
          });
          // setState(() {
          //   boardCardList.insert(index + 1, value);
          //   handCardList.remove(value);
          // });
        } else {
          print("No");
        }
        print("Value = $value");
      },
    );
  }
}
