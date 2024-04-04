import 'package:flutter/material.dart';
import 'package:timeline/holiday_game/bloc/holiday_bloc.dart';
import 'package:timeline/utils/date_formatter.dart';

class IsRightAnswer extends StatelessWidget {
  const IsRightAnswer(this.state, {super.key});

  final HolidayState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        state.rightAnswer
            ? const Text(
                "Верно!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.green),
              )
            : const Text("НЕ верно!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.deepOrange)),
        Text(
          "${state.previousGameCard!.name} (${const CustomDateFormatter().getFullMonth(state.previousGameCard!.date)})",
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
