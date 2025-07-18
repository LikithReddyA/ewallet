import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/expense/data/models/expense_model.dart';
import 'package:ewallet/features/expense/domain/entities/expense.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class ExpenseMapper {
  static Expense toEntity(
    ExpenseModel expenseModel,
    Category transactionCategory,
    Source fromSource,
  ) {
    return Expense(
      id: expenseModel.id,
      title: expenseModel.title,
      description: expenseModel.description,
      amount: Money.inPaise(expenseModel.amountInPaise),
      createdAt: DateTime.parse(expenseModel.createdAtDateTime),
      transactionDate: DateTime.parse(expenseModel.transactionDateTime),
      transactionCategory: transactionCategory,
      transactionType: stringToTransactionType(expenseModel.transactionType),
      fromSource: fromSource,
    );
  }

  static ExpenseModel toModel(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      title: expense.title,
      description: expense.description,
      amountInPaise: expense.amount.amountInPaise,
      createdAtDateTime: expense.createdAt.toIso8601String(),
      transactionDateTime: expense.transactionDate.toIso8601String(),
      transactionType: transactionTypeToString(expense.transactionType),
      transactionCategoryId: expense.transactionCategory.categoryId,
      fromSourceId: expense.fromSource.sourceId,
    );
  }

  static TransactionType stringToTransactionType(String transactionType) {
    return TransactionType.values.firstWhere(
      (e) => e.name == transactionType,
      orElse: () => TransactionType.income,
    );
  }

  static String transactionTypeToString(TransactionType transactionType) =>
      transactionType.name;
}
