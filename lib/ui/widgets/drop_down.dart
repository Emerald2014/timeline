import 'package:flutter/material.dart';

import '../settings_screen.dart';

Widget dropDown(BuildContext context, String dropDownValue, List<String> values,
    void Function(String newValue, bool boolValue, String settingsType) callSetState) {
  return DropdownButton<String>(
    value: dropDownValue,
    onChanged: (String? newValue) {
      callSetState(newValue!, false, SettingsType.dropDown as String);
      // setState(() {
      //   dropDownValue = newValue!;
      // });
    },
    items: values.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
