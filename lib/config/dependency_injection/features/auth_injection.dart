import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:ewallet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_session_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/login_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/refresh_user_session_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/refresh_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/register_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> initAuthDependencies(GetIt sl) async {
  /// Datasource

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  /// Repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  /// UseCases

  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));

  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl()));

  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));

  sl.registerLazySingleton(() => GetCurrentUserUsecase(authRepository: sl()));

  sl.registerLazySingleton(() => RefreshUserUsecase(authRepository: sl()));

  sl.registerLazySingleton(
    () => SendVerificationEmailUsecase(authRepository: sl()),
  );

  sl.registerLazySingleton(
    () =>
        CreateAccountUsecase(authRepository: sl(), userProfileRepository: sl()),
  );

  sl.registerLazySingleton(
    () => LoginUserUsecase(authRepository: sl(), userProfileRepository: sl()),
  );

  sl.registerLazySingleton(
    () => RefreshUserSessionUsecase(
      authRepository: sl(),
      userProfileRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCurrentSessionUsecase(
      authRepository: sl(),
      userProfileRepository: sl(),
    ),
  );

  /// Bloc

  sl.registerLazySingleton(
    () => AuthBloc(
      logoutUsecase: sl(),
      sendVerificationEmailUsecase: sl(),
      createAccountUsecase: sl(),
      loginUserUsecase: sl(),
      getCurrentSessionUsecase: sl(),
      refreshUserSessionUsecase: sl(),
    ),
  );
}
