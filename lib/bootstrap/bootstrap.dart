import 'package:auth_repository/auth_repository.dart';
import 'package:ewallet/app/app.dart';
import 'package:ewallet/bootstrap/app_bloc_observer.dart';
import 'package:ewallet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  runApp(
    App(
      authRepo: FirebaseAuthRepository(),
      walletRepo: WalletFirebaseRepository(),
    ),
  );
}
