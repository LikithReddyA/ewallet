import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:ewallet/features/income/data/datasources/income_datasource.dart';
import 'package:ewallet/features/income/data/mapper/income_mapper.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/repositories/income_repository.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final AuthRepository authRepository;
  final SourceRepository sourceRepository;
  final IncomeDatasource incomeDatasource;

  IncomeRepositoryImpl({
    required this.authRepository,
    required this.sourceRepository,
    required this.incomeDatasource,
  });

  Future<String?> getCurrentUserId() async {
    final result = await authRepository.getCurrentUserId();
    return result.fold((failure) => null, (id) => id);
  }

  @override
  Future<Either<Failure, void>> addIncome(IncomeParams params) async {
    try {
      final userId = await getCurrentUserId();

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
}
