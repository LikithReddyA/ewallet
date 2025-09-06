import 'package:ewallet/features/income/data/models/income_model.dart';

abstract class IncomeDatasource {
  Future<void> addIncome(String userId, IncomeModel incomeModel);
  Future<List<IncomeModel>> fetchAllIncome(String userId);
}
