import 'package:ewallet/config/app/app.dart';
import 'package:ewallet/config/app/app_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInitializer.initialize();
  runApp(const App());
}
