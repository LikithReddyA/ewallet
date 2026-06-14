import 'package:ewallet/config/dependency_injection/features/auth_injection.dart';
import 'package:ewallet/config/dependency_injection/features/profile_injection.dart';
import 'package:ewallet/config/dependency_injection/features/settings_injection.dart';
import 'package:ewallet/config/dependency_injection/services/firebase_injection.dart';
import 'package:ewallet/config/dependency_injection/services/sharedpreferences_injection.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initFirebaseDependencies(sl);
  await initSharedPreferencesDependencies(sl);
  await initAuthDependencies(sl);
  await initSettingsDependencies(sl);
  await initProfileDependencies(sl);
}
