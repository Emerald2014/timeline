import 'package:flutter/material.dart';

Widget checkBox(BuildContext context, Map<String, bool> values,
    void Function(bool newValue) callSetState) {
  return ListView(children:
    values.keys.map((String key) {
      return CheckboxListTile(
        title: Text(key),
        value: values[key],
        onChanged: (bool? newValue) {
          //   (Map<String,  bool> changeBool) {
          // callSetState(changeBool);
          // setState(() {
          //   values[key] = value;
          // });
        },
      );
    }).toList(),
  );
}
