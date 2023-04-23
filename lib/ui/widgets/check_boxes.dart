import 'package:flutter/material.dart';

Widget checkBox(
    BuildContext context,
    Map<String, bool> values,
    void Function(String newValue, bool boolValue, String settingsType)
        callSetState) {
  return Expanded(
    child: ListView(
      children: values.keys.map((String key) {
        return CheckboxListTile(
          title: Text(key),
          value: values[key],
          onChanged: (bool? newValue) {
            callSetState(values[key] as String, newValue!, "checkBox");
          },
        );
      }).toList(),
    ),
  );
}
