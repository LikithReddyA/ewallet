import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ewallet/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:ewallet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/login_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/register_usecase.dart';
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

  /// Bloc

  sl.registerLazySingleton(
    () => AuthBloc(
      loginUsecase: sl(),
      registerUsecase: sl(),
      logoutUsecase: sl(),
      getCurrentUserUsecase: sl(),
    ),
  );
}
