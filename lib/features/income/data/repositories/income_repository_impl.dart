import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/utils/helpers/firebase_helper.dart';
import 'package:ewallet/features/income/data/datasources/income_datasource.dart';
import 'package:ewallet/features/income/data/mapper/income_mapper.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/repositories/income_repository.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/category/domain/repositories/category_repository.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final FirebaseHelper firebaseHelper;
  final SourceRepository sourceRepository;
  final IncomeDatasource incomeDatasource;
  final CategoryRepository categoryRepository;

  IncomeRepositoryImpl({
    required this.firebaseHelper,
    required this.sourceRepository,
    required this.incomeDatasource,
    required this.categoryRepository,
  });

  @override
  Future<Either<Failure, void>> addIncome(IncomeParams params) async {
    try {
      final userId = await firebaseHelper.getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      // save the transaction
      await incomeDatasource.addIncome(
        userId,
        IncomeMapper.toModel(
          Income(
            id: params.incomeId,
            title: params.title,
            description: params.description,
            amount: params.amount,
            createdAt: DateTime.now(),
            transactionDate: params.transactionDate,
            transactionCategory: params.transactionCategory,
            transactionType: params.transactionType,
            toSource: params.toSource,
          ),
        ),
      );

      // update balance in source
      await sourceRepository.addBalance(
        params.toSource.sourceId,
        params.amount,
      );

      // ignore: void_checks
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Income>>> fetchAllIncome() async {
    try {
      final userId = await firebaseHelper.getCurrentUserId();

      if (userId == null) {
        return Left(
          FirebaseAuthFailure(firebaseFailureMessage: "userId-not-found"),
        );
      }

      final incomeModels = await incomeDatasource.fetchAllIncome(userId);

      // Create list of futures of Either<Failure, Income>
      final List<Future<Either<Failure, Income>>>
      futureIncomeResults = incomeModels.map<Future<Either<Failure, Income>>>((
        incomeModel,
      ) async {
        final categoryResult = await categoryRepository.getCategoryById(
          incomeModel.transactionCategoryId,
        );

        final sourceResult = await sourceRepository.getSourceById(
          incomeModel.toSourceId,
        );

        // Handle Category
        Category? category;
        final categoryFailure = categoryResult.fold((failure) => failure, (
          value,
        ) {
          category = value;
          return null;
        });

        if (categoryFailure != null) {
          return Left(categoryFailure);
        }

        // Handle Source
        Source? source;
        final sourceFailure = sourceResult.fold((failure) => failure, (value) {
          source = value;
          return null;
        });

        if (sourceFailure != null) {
          return Left(sourceFailure);
        }

        return Right(IncomeMapper.toEntity(incomeModel, category!, source!));
      }).toList();

      // Wait for all futures to complete
      final List<Either<Failure, Income>> results = await Future.wait(
        futureIncomeResults,
      );

      // Check results for any failure
      List<Income> incomes = [];
      for (final result in results) {
        if (result.isLeft()) {
          return Left(
            result.fold(
              (l) => l,
              (_) =>
                  ServerFailure(serverFailureMessage: "something-went-wrong"),
            ),
          );
        }
        incomes.add(result.getOrElse(() => throw UnimplementedError()));
      }

      return Right(incomes);
    } catch (e) {
      return Left(ServerFailure(serverFailureMessage: e.toString()));
    }
  }
}
