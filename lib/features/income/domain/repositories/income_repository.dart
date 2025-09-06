import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';

abstract class IncomeRepository {
  Future<Either<Failure, void>> addIncome(IncomeParams params);
  Future<Either<Failure, List<Income>>> fetchAllIncome();
}
