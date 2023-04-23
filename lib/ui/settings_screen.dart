import 'package:flutter/material.dart';
import 'package:timeline/ui/widgets/check_boxes.dart';
import 'package:timeline/ui/widgets/drop_down.dart';

import '../data/enums.dart';

List<String> levels2 = Level.values.map((e) => e.name).toList();
Map<String, bool> category =
    Category.values.map((e) => e.name).toList().asMap().cast<String, bool>();

class SettingScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  String dropdownValue = levels2.first;

  // late  Function(String newValue) callSetState;

  callback(var newValue) {
    if (newValue is String) {
      setState(() {
        dropdownValue = newValue;
      });
      print("newValue = $newValue");
    } else if (newValue is Map<String, bool>) {
      // setState(() {
      //   category[newValue] = newValue;
      // });
    }
  }

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
        dropDown(context, dropdownValue, levels2, callback),
        Text(
          "Выберите категорию игры",
          style: TextStyle(fontSize: 20),
        ),
        // checkBox(context, category, callback),
      ]),
    );
  }
}
