import 'package:flutter/material.dart';
import 'package:timeline/data/card_list.dart';
import 'package:timeline/model/game_card.dart';

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
  List handCardList = cardListOnHand;
  List<GameCard> boardCardList = cardListOnBoard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[200],
      body: SafeArea(
        child: Column(
          children: [
//            list view separated will build a widget between 2 list items to act as a separator
            Expanded(
                child: ListView.separated(
              itemBuilder: _buildListAItems,
              separatorBuilder: _buildDragTargetsA,
              itemCount: handCardList.length,
            )),
            Expanded(
                child: ListView.separated(
              itemBuilder: _buildListBItems,
              separatorBuilder: _buildDragTargetsB,
              itemCount: boardCardList.length,
            )),
          ],
        ),
      ),
    );
  }

//  builds the widgets for List B items
  Widget _buildListBItems(BuildContext context, int index) {
    GameCard itemB = boardCardList[index];

    return Draggable<String>(
//      the value of this draggable is set using data
      data: itemB.name,
//      the widget to show under the users finger being dragged
      feedback: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemB.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
//      what to display in the child's position when being dragged
      childWhenDragging: Container(
        color: Colors.grey,
        width: 40,
        height: 40,
      ),
//      widget in idle state
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemB.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

//  builds the widgets for List A items
  Widget _buildListAItems(BuildContext context, int index) {
    GameCard itemA = handCardList[index];
    return Draggable<String>(
      data: itemA.name,
      feedback: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemA.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.grey,
        width: 40,
        height: 40,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemA.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

//  will return a widget used as an indicator for the drop position
  Widget _buildDropPreview(BuildContext context, String value) {
    return Card(
      color: Colors.lightBlue[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

//  builds DragTargets used as separators between list items/widgets for list A
  Widget _buildDragTargetsA(BuildContext context, int index) {
    return DragTarget<GameCard>(
//      builder responsible to build a widget based on whether there is an item being dropped or not
      builder: (context, candidates, rejects) {
        return candidates.length > 0
            ? _buildDropPreview(context, candidates[0]!.name )
            : Container(
                width: 5,
                height: 5,
              );
      },
//      condition on to accept the item or not
//       onWillAccept: (value) => !listA.contains(value),
//      what to do when an item is accepted
      onAccept: (value) {

        if(compareYear(index, value)) {
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
  }

  bool compareYear(int indexBoardCard, GameCard cardFromHand) {
    bool isHandCardYearLatest = true;
    GameCard prevBoardCard = boardCardList[indexBoardCard ];
    int yearPrevBoardCard = prevBoardCard.year;
    GameCard nextBoardCard = boardCardList[indexBoardCard + 1];
    int yearNextBoardCard = nextBoardCard.year;
    if (indexBoardCard > 0) {
      isHandCardYearLatest = cardFromHand.year > yearPrevBoardCard;
    } else if (indexBoardCard == 0) {
      isHandCardYearLatest = cardFromHand.year < yearNextBoardCard;
    } else {
      false;
    }

    return isHandCardYearLatest;
  }

//  builds drag targets for list B
  Widget _buildDragTargetsB(BuildContext context, int index) {
    return DragTarget<String>(
      builder: (context, candidates, rejects) {
        return candidates.length > 0
            ? _buildDropPreview(context, candidates[0]!)
            : const SizedBox(
                width: 5,
                height: 5,
              );
      },
      onWillAccept: (value) => !boardCardList.contains(value),
      onAccept: (value) {
        GameCard item = boardCardList[0];

        for(var i in handCardList) {
          if(value == i.name) { item = i;}
        }
        if(compareYear(index, item)) {
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
