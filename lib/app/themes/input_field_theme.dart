import 'package:flutter/material.dart';

class InputFieldTheme {
  static final inputFieldLightTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
    hintStyle: TextStyle(
      color: Colors.grey.shade400,
      fontStyle: FontStyle.italic,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
  static final inputFieldDarkTheme = InputDecorationTheme();
}
