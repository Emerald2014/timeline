import 'package:flutter/material.dart';
import 'package:timeline/model/game_card.dart';
import 'package:timeline/model/settings.dart';
import 'package:timeline/ui/widgets/drop_down.dart';

import '../data/card_list.dart';
import '../data/enums.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  List<String> categoryList = Category.values.map((e) => e.name).toList();
  List<String> levels = Level.values.map((e) => e.name).toList();

  Map<String, bool> categoryMap = {};
  int cardsCount = 0;
  Set<String> changedCategory = {};
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = levels.first;
    for (var item in categoryList) {
      categoryMap[item] = false;
    }
    // cardsCount = cardCount(settings);
    super.initState();
  }

  callback(String stringValue, bool boolValue, String settingsType) {
    if (settingsType == SettingsType.dropDown.name) {
      setState(() {
        dropdownValue = stringValue;
        // cardsCount = cardCount(settingsModify());
      });
    } else if (settingsType == SettingsType.checkBox.name) {
      setState(() {
        categoryMap[stringValue] = boolValue;
        // cardsCount = cardCount(settingsModify());
      });
    }
  }

  Settings settingsModify(List<String> listCategory) {
    Set<Category> categorySet = {};
    for (Category categoryInCategoryEnum in Category.values) {
      for (String categoryName in listCategory) {
        if (categoryInCategoryEnum.name.contains(categoryName)) {
          categorySet.add(categoryInCategoryEnum);
        }
      }
    }

    List<String> listCentury = [Century.earlier.toString()];
    return Settings(category: categorySet.toList(), century: listCentury);
  }

  int cardCount(Settings settings) {
    List<GameCard> cardList = cardListOnHand;
    int count = 0;
    for (var item in cardList) {
      for (var changedCategory in settings.category) {
        if (item.category == changedCategory) {
          count++;
        }
      }
    }
    return count;
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
        dropDown(context, dropdownValue, levels, callback),
        Text(
          "Выберите категорию игры",
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          child: ListView(
            children: categoryMap.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: categoryMap[key],
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? newValue) {
                  // callSetState(values[key] as String, newValue!,
                  //     SettingsType.checkBox as String);
                  setState(() {
                    categoryMap[key] = newValue!;
                    if (categoryMap[key] == true) {
                      changedCategory.add(key);
                    } else {
                      changedCategory.remove(key);
                    }
                    cardsCount =
                        cardCount(settingsModify(changedCategory.toList()));
                  });
                },
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
            onPressed: () {},
            child: Text("Карт в игре: ${cardsCount.toString()}"))
        // Container(
        //   color: Colors.red,
        //   child: Material(child: checkBox(context, category, callback)),
        // )
      ]),
    );
  }
}
