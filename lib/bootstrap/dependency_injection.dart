import 'package:ewallet/features/auth/di/dependency_injection.dart';
import 'package:ewallet/features/profile/di/user_profile_dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  authDI(sl);
  userProfileDI(sl);
}
