import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

Future<void> initFirebaseDependencies(GetIt sl) async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(()=>FirebaseFirestore.instance);
}
