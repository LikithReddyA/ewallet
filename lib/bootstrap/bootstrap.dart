import 'package:ewallet/app/app.dart';
import 'package:ewallet/bootstrap/app_bloc_observer.dart';
import 'package:ewallet/bootstrap/dependency_injection.dart';
import 'package:ewallet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
