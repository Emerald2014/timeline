import 'package:flutter/material.dart';
import 'package:timeline/start_menu/ui/start_menu_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Линия времени",
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(72, 74, 126, 1),
          ),
        ),
        home: const StartMenuScreen(),
      );
}
