import 'package:flutter/material.dart';

Widget dropDown(
    BuildContext context,
    String dropDownValue,
    List<String> values,
    void Function(String newValue, bool boolValue, String settingsType)
        callSetState) {
  return DropdownButton<String>(
    value: dropDownValue,
    onChanged: (String? newValue) {
      callSetState(newValue!, false, "dropDown");
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
