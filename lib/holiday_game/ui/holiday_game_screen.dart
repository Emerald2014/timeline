import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline/holiday_game/bloc/holiday_bloc.dart';
import 'package:timeline/holiday_game/repository/holiday_repository.dart';

class HolidayGameScreen extends StatelessWidget {
  const HolidayGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolidayBloc(HolidayRepository()),
      child: HolidayGameView(),
    );
  }
}

class HolidayGameView extends StatefulWidget {
  const HolidayGameView({super.key});

  @override
  State<StatefulWidget> createState() => _HolidayGameViewState();
}

class _HolidayGameViewState extends State<HolidayGameView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Игра Праздники"),),
      body: BlocBuilder<HolidayBloc, HolidayState>(builder: (context, state) {
        return SizedBox();
      }),
    );
  }
}
