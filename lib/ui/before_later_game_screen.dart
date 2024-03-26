import 'package:flutter/material.dart';

class BeforeLaterGameScreen extends StatefulWidget {
  @override
  _BeforeLaterGameScreenState createState() => _BeforeLaterGameScreenState();
}

class _BeforeLaterGameScreenState extends State<BeforeLaterGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Игра \"Раньше-позже\"")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
