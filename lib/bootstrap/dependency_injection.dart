import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/auth/di/dependency_injection.dart';
import 'package:ewallet/features/income/di/income_di.dart';
import 'package:ewallet/features/profile/di/user_profile_dependency_injection.dart';
import 'package:ewallet/features/shared/category/di/category_dependency_injection.dart';
import 'package:ewallet/features/shared/source/di/source_dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  authDI(sl);
  userProfileDI(sl);
  categoryDI(sl);
  sourceDI(sl);
  incomeDI(sl);
}
