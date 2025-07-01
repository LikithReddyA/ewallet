import 'package:ewallet/features/auth/data/datasources/auth_datasource.dart';
import 'package:ewallet/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:ewallet/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/auth/domain/usecases/get_auth_user.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:ewallet/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:ewallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

void authDI(GetIt sl) {
  sl.registerLazySingleton<AuthDatasource>(
    () => FirebaseAuthDatasource(firebaseAuth: sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDatasource: sl<AuthDatasource>()),
  );

  //usecases
  sl.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthUser>(
    () => GetAuthUser(authRepository: sl<AuthRepository>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUsecase: sl<SignUpUsecase>(),
      signInUsecase: sl<SignInUsecase>(),
      signOutUsecase: sl<SignOutUsecase>(),
      getAuthUser: sl<GetAuthUser>(),
    ),
  );
}
