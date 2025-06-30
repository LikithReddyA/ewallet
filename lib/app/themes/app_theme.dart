import 'package:ewallet/app/themes/input_field_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: InputFieldTheme.inputFieldLightTheme,
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    inputDecorationTheme: InputFieldTheme.inputFieldDarkTheme,
  );
}
