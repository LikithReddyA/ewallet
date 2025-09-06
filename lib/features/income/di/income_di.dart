import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/core/utils/helpers/firebase_helper.dart';
import 'package:ewallet/features/income/data/datasources/firebase_income_datasource.dart';
import 'package:ewallet/features/income/data/datasources/income_datasource.dart';
import 'package:ewallet/features/income/data/repositories/income_repository_impl.dart';
import 'package:ewallet/features/income/domain/repositories/income_repository.dart';
import 'package:ewallet/features/income/domain/usecases/add_income_usecase.dart';
import 'package:ewallet/features/income/domain/usecases/fectch_all_incomes_usecase.dart';
import 'package:ewallet/features/income/presentation/bloc/income_bloc.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';
import 'package:get_it/get_it.dart';

void incomeDI(GetIt sl) {
  sl.registerLazySingleton<IncomeDatasource>(
    () => FirebaseIncomeDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<IncomeRepository>(
    () => IncomeRepositoryImpl(
      firebaseHelper: sl<FirebaseHelper>(),
      sourceRepository: sl<SourceRepository>(),
      incomeDatasource: sl<IncomeDatasource>(),
      categoryRepository: sl<CategoryRepository>(),
    ),
  );

  sl.registerLazySingleton<AddIncomeUsecase>(
    () => AddIncomeUsecase(incomeRepository: sl<IncomeRepository>()),
  );
  sl.registerLazySingleton<FectchAllIncomesUsecase>(
    () => FectchAllIncomesUsecase(incomeRepository: sl<IncomeRepository>()),
  );

  sl.registerFactory<IncomeBloc>(
    () => IncomeBloc(
      addIncomeUsecase: sl<AddIncomeUsecase>(),
      fectchAllIncomesUsecase: sl<FectchAllIncomesUsecase>(),
    ),
  );
}
