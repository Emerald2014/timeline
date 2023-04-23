import 'package:flutter/material.dart';
import 'package:timeline/ui/widgets/check_boxes.dart';
import 'package:timeline/ui/widgets/drop_down.dart';

import '../data/enums.dart';

List<String> levels2 = Level.values.map((e) => e.name).toList();


Map<String, bool> category2 = {"a": false, "bn": true};

class SettingScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  List<String> categoryList = Category.values.map((e) => e.name).toList();

  String dropdownValue = levels2.first;
  Map<String, bool> category = {};

  // late  Function(String newValue) callSetState;

  callback(String stringValue, bool boolValue, String settingsType) {
    if (settingsType == SettingsType.dropDown) {
      setState(() {
        dropdownValue = stringValue;
      });
      print("newValue = $stringValue");
    } else if (settingsType == SettingsType.checkBox) {
      setState(() {
        category[stringValue] = boolValue;
      });
    }
  }

  @override
  void initState() {

    for (var item in categoryList) {
      category[item] = false;
      print("item = $item");
    }
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
        Container(
            color: Colors.red,
            child: Material(
              child:             checkBox(context, category, callback)),

            )
      ]),
    );
  }
}

enum SettingsType { dropDown, checkBox }
