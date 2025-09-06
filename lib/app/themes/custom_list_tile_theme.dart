import 'package:flutter/material.dart';

class CustomListTileTheme {
  static final listTileLightTheme = ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    tileColor: Colors.grey[100],
    textColor: Colors.black87,
    iconColor: Colors.green,
    titleTextStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitleTextStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
    leadingAndTrailingTextStyle: TextStyle(fontSize: 20),
  );
  static final listTileDarkTheme = ListTileThemeData();
}
