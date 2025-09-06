import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/income/domain/repositories/income_repository.dart';

class FectchAllIncomesUsecase extends Usecase<List<Income>, NoParams> {
  final IncomeRepository incomeRepository;

  FectchAllIncomesUsecase({required this.incomeRepository});
  @override
  Future<Either<Failure, List<Income>>> call(NoParams params) async {
    return await incomeRepository.fetchAllIncome();
  }
}
