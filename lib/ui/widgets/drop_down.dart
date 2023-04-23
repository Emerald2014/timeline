import 'package:flutter/material.dart';

Widget dropDown(BuildContext context, String dropDownValue, List<String> values,
    void Function(String newValue) callSetState) {
  return DropdownButton<String>(
    value: dropDownValue,
    onChanged: (String? newValue) {
      callSetState(newValue!);
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
