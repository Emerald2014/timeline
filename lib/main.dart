import 'package:flutter/material.dart';
import 'package:timeline/ui/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MenuScreen(),
      );
}
