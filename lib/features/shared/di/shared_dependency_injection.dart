import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/shared/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/data/datasources/cateogry_firebase_datasource.dart';
import 'package:ewallet/features/shared/data/datasources/source_datasource.dart';
import 'package:ewallet/features/shared/data/datasources/source_firebase_datasource.dart';
import 'package:ewallet/features/shared/data/repositories/category_repository_impl.dart';
import 'package:ewallet/features/shared/data/repositories/source_repository_impl.dart';
import 'package:ewallet/features/shared/domain/repositories/category_repository.dart';
import 'package:ewallet/features/shared/domain/repositories/source_repository.dart';
import 'package:get_it/get_it.dart';

void sharedDI(GetIt sl) {
  sl.registerLazySingleton<SourceDatasource>(
    () => SourceFirebaseDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<CategoryDatasource>(
    () =>
        CateogryFirebaseDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<SourceRepository>(
    () => SourceRepositoryImpl(
      sourceDatasource: sl<SourceDatasource>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      categoryDatasource: sl<CategoryDatasource>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
}
