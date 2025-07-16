import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/shared/category/data/datasources/category_datasource.dart';
import 'package:ewallet/features/shared/category/data/datasources/cateogry_firebase_datasource.dart';
import 'package:ewallet/features/shared/category/data/repositories/category_repository_impl.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';
import 'package:ewallet/features/shared/category/domain/usecases/fetch_categories_usecase.dart';
import 'package:ewallet/features/shared/category/presentation/bloc/category_bloc.dart';
import 'package:get_it/get_it.dart';

void categoryDI(GetIt sl) {
  sl.registerLazySingleton<CategoryDatasource>(
    () =>
        CateogryFirebaseDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      categoryDatasource: sl<CategoryDatasource>(),
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<FetchCategoriesUsecase>(
    () => FetchCategoriesUsecase(categoryRepository: sl<CategoryRepository>()),
  );

  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(fetchCategoriesUsecase: sl<FetchCategoriesUsecase>()),
  );
}
