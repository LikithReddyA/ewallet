import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/shared/source/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/source/data/datasources/source_firebase_datasource.dart';
import 'package:ewallet/features/shared/source/data/repositories/source_repository_impl.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';
import 'package:ewallet/features/shared/source/domain/usecases/get_sources_usecase.dart';
import 'package:ewallet/features/shared/source/presentation/bloc/source_bloc.dart';
import 'package:get_it/get_it.dart';

void sourceDI(GetIt sl) {
  sl.registerLazySingleton<SourceDatasource>(
    () => SourceFirebaseDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<SourceRepository>(
    () => SourceRepositoryImpl(
      sourceDatasource: sl<SourceDatasource>(),
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<GetSourcesUsecase>(
    () => GetSourcesUsecase(sourceRepository: sl<SourceRepository>()),
  );

  sl.registerFactory<SourceBloc>(
    () => SourceBloc(getSourcesUsecase: sl<GetSourcesUsecase>()),
  );
}
