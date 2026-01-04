import 'package:ewallet/app/app.dart';
import 'package:ewallet/bootstrap/app_bloc_observer.dart';
import 'package:ewallet/bootstrap/dependency_injection.dart';
import 'package:ewallet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  Bloc.observer = AppBlocObserver();
  //TODO: Need to fix the status bar color appropriately as per the scaffold background color
  // Better to create a centralized section for colors
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(App());
}
