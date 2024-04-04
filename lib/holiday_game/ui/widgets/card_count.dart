import 'package:flutter/material.dart';

class CardCount extends StatelessWidget {
  const CardCount(
      {super.key, required this.totalGameCard, required this.playedGameCard});

  final int totalGameCard;
  final int playedGameCard;

  @override
  Widget build(BuildContext context) {
    double currentIndicatorPosition =
        1 - (1 / totalGameCard * (totalGameCard - playedGameCard));

    return Stack(
      children: [
        LinearProgressIndicator(
          value: currentIndicatorPosition,
          minHeight: 24,
          color: Colors.orange,
          backgroundColor: Colors.yellowAccent,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        Center(
          child: Text(
            "Прогресс: $playedGameCard / $totalGameCard",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
