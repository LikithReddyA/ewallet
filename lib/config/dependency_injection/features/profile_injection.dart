import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource_impl.dart';
import 'package:ewallet/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_usecase.dart';
import 'package:ewallet/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:ewallet/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> initProfileDependencies(GetIt sl) async {
  //Datasources
  sl.registerLazySingleton<UserProfileDatasource>(
    () => UserProfileDatasourceImpl(firebaseFirestore: sl()),
  );

  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(userProfileDatasource: sl()),
  );

  //usecases
  sl.registerLazySingleton(
    () => CreateUserProfileUsecase(userProfileRepository: sl()),
  );

  sl.registerLazySingleton(
    () => GetUserProfileUsecase(userProfileRepository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateUserProfileUsecase(userProfileRepository: sl()),
  );
}
