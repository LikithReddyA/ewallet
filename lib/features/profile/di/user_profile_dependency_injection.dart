import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ewallet/features/profile/data/datasources/firebase_userprofile_datasource.dart';
import 'package:ewallet/features/profile/data/datasources/user_profile_datasource.dart';
import 'package:ewallet/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:ewallet/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:ewallet/features/profile/domain/usecases/create_user_profile_usecase.dart';
import 'package:ewallet/features/profile/domain/usecases/is_profile_created_usecase.dart';
import 'package:ewallet/features/profile/presentation/blocs/user_profile_bloc.dart';
import 'package:get_it/get_it.dart';

void userProfileDI(GetIt sl) {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<UserProfileDatasource>(
    () => FirebaseUserprofileDatasource(
      firebaseFirestore: sl<FirebaseFirestore>(),
    ),
  );

  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(
      userProfileDatasource: sl<UserProfileDatasource>(),
    ),
  );

  //usecases
  sl.registerLazySingleton<CreateUserProfileUsecase>(
    () => CreateUserProfileUsecase(
      userProfileRepository: sl<UserProfileRepository>(),
    ),
  );
  sl.registerLazySingleton<IsProfileCreatedUsecase>(
    () => IsProfileCreatedUsecase(
      userProfileRepository: sl<UserProfileRepository>(),
    ),
  );

  //blocs
  sl.registerFactory<UserProfileBloc>(
    () => UserProfileBloc(
      authBloc: sl<AuthBloc>(),
      createUserProfileUsecase: sl<CreateUserProfileUsecase>(),
      isProfileCreatedUsecase: sl<IsProfileCreatedUsecase>(),
    ),
  );
}
