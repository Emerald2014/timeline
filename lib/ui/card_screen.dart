import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber[200],
        body: Center(
          child: Column(
            children: [
              Text("Название карточки"),
              Image(image: AssetImage("assets/no_image.jpg")),
              Text("Год")
            ],
          ),
        ),
      );
}