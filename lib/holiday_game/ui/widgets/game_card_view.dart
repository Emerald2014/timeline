import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/holiday_game/bloc/holiday_bloc.dart';
import 'package:timeline/holiday_game/model/models.dart';

class GameCardView extends StatelessWidget {
  const GameCardView({required this.gameCard, super.key});

  final HolidayGameCard gameCard;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<HolidayBloc>().add(HolidayCardPressed(gameCard));
        },
        child: Card(
          child: SizedBox(
            width: 150,
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      gameCard.name,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
