import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewallet/core/utils/helpers/firebase_helper.dart';
import 'package:ewallet/features/expense/data/datasources/expense_datasource.dart';
import 'package:ewallet/features/expense/data/datasources/firebase_expense_datasource.dart';
import 'package:ewallet/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:ewallet/features/expense/domain/repositories/expense_repository.dart';
import 'package:ewallet/features/expense/domain/usecase/add_expense_usecase.dart';
import 'package:ewallet/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';
import 'package:get_it/get_it.dart';

void expenseDI(GetIt sl) {
  sl.registerLazySingleton<ExpenseDatasource>(
    () => FirebaseExpenseDatasource(firebaseFirestore: sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      sl<FirebaseHelper>(),
      sl<SourceRepository>(),
      expenseDatasource: sl<ExpenseDatasource>(),
    ),
  );

  sl.registerLazySingleton(
    () => AddExpenseUsecase(expenseRepository: sl<ExpenseRepository>()),
  );

  sl.registerFactory<ExpenseBloc>(
    () => ExpenseBloc(addExpenseUsecase: sl<AddExpenseUsecase>()),
  );
}
