import 'package:ewallet/config/dependency_injection/injection_container.dart';
import 'package:ewallet/config/firebase/firebase_config.dart';
import 'package:flutter/material.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseConfig.initialize();
    await initDependencies();
  }
}
