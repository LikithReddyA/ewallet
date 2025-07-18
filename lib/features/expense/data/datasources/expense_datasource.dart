import 'package:ewallet/features/expense/data/models/expense_model.dart';

abstract class ExpenseDatasource {
  Future<void> addExpense(String userId, ExpenseModel expenseModel);
}
