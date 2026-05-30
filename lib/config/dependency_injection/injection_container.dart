import 'package:ewallet/config/dependency_injection/features/auth_injection.dart';
import 'package:ewallet/config/dependency_injection/services/firebase_injection.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initFirebaseDependencies(sl);
  await initAuthDependencies(sl);
}
