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
  List<String> centuryList = Century.values.map((e) => e.name).toList();
  List<String> levels = Level.values.map((e) => e.name).toList();

  Map<String, bool> categoryMap = {};
  Map<String, bool> centuryMap = {};
  int cardsCount = 0;
  Set<String> changedCategory = {};
  Set<String> changedCentury = {};
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = levels.first;
    for (var item in categoryList) {
      categoryMap[item] = false;
    }
    for (var item in centuryList) {
      centuryMap[item] = false;
    }
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

  Settings settingsModify(List<String> listCategory, List<String> listCentury) {
    Set<Category> categorySet = {};
    Set<Century> centurySet = {};
    for (Category categoryInCategoryEnum in Category.values) {
      for (String categoryName in listCategory) {
        if (categoryInCategoryEnum.name.contains(categoryName)) {
          categorySet.add(categoryInCategoryEnum);
        }
      }
      for (Century centuryInCenturyEnum in Century.values) {
        for (String centuryName in listCentury) {
          if (centuryInCenturyEnum.name.contains(centuryName)) {
            centurySet.add(centuryInCenturyEnum);
          }
        }
      }
    }
    return Settings(
        category: categorySet.toList(), century: centurySet.toList());
  }

  int cardCount(Settings settings) {
    List<GameCard> cardList = cardListOnHand;
    int count = 0;
    for (var item in cardList) {
      for (var changedCategory in settings.category) {
        for (var changedCentury in settings.century) {
          if (item.category == changedCategory &&
              item.century == changedCentury) {
            count++;
          }
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
                  setState(() {
                    categoryMap[key] = newValue!;
                    if (categoryMap[key] == true) {
                      changedCategory.add(key);
                    } else {
                      changedCategory.remove(key);
                    }
                    cardsCount = cardCount(settingsModify(
                        changedCategory.toList(), changedCentury.toList()));
                  });
                },
              );
            }).toList(),
          ),
        ),
        Text("Выберите временной интервал карт:",
            style: TextStyle(fontSize: 20)),
        Expanded(
          child: ListView(
            children: centuryMap.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: centuryMap[key],
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? newValue) {
                  setState(() {
                    centuryMap[key] = newValue!;
                    if (centuryMap[key] == true) {
                      changedCentury.add(key);
                    } else {
                      changedCentury.remove(key);
                    }
                    cardsCount = cardCount(settingsModify(
                        changedCategory.toList(), changedCentury.toList()));
                  });
                },
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
            onPressed: () {},
            child: Text("Карт в игре: ${cardsCount.toString()}"))
      ]),
    );
  }
}
