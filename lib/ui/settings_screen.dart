import 'package:flutter/material.dart';
import 'package:timeline/model/settings.dart';

import '../data/enums.dart';
const List<String> levels = <String>['One', 'Two', 'Three', 'Four'];
List<String> levels2 = Level.values.map((e) => e.name).toList();


class SettingScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  late ClassType classType;
  // List<String> levels2 = Level.values.cast<String>().toList();

  // late String dropdownValue;
  String dropdownValue = levels2.first;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
      ),
      body: Column(children: [
        Text(
          "Выберите сложность игры",
          style: TextStyle(fontSize: 20),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newLevel) {
            setState(() {
              dropdownValue = newLevel!;
            });
          },
          items: levels2.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

enum ClassType { A, B, C, D }
