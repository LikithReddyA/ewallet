import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/income/domain/repositories/income_repository.dart';
import 'package:ewallet/features/income/domain/usecases/income_params.dart';

class AddIncomeUsecase implements Usecase<void, IncomeParams> {
  final IncomeRepository incomeRepository;

  AddIncomeUsecase({required this.incomeRepository});

  @override
  Future<Either<Failure, void>> call(IncomeParams params) {
    return incomeRepository.addIncome(params);
  }
}
