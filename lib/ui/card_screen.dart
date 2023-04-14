import 'package:flutter/material.dart';
import 'package:timeline/model/game_card.dart';

class CardScreen extends StatelessWidget {
  final GameCard gameCard;

  const CardScreen({super.key, required this.gameCard});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber[200],
        body: Center(
          child: Column(
            children: [
              Text(gameCard.name),
              // Image(image: AssetImage("assets/no_image.jpg")),
              Text(gameCard.year.toString())
            ],
          ),
        ),
      );
}
