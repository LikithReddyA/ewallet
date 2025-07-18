import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/income/data/models/income_model.dart';
import 'package:ewallet/features/income/domain/entities/income.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class IncomeMapper {
  static Income toEntity(
    IncomeModel incomeModel,
    Category transactionCategory,
    Source toSource,
  ) {
    return Income(
      id: incomeModel.id,
      title: incomeModel.title,
      description: incomeModel.description,
      amount: Money.inPaise(incomeModel.amountInPaise),
      createdAt: DateTime.parse(incomeModel.createdAtDateTime),
      transactionDate: DateTime.parse(incomeModel.transactionDateTime),
      transactionCategory: transactionCategory,
      transactionType: stringToTransactionType(incomeModel.transactionType),
      toSource: toSource,
    );
  }

  static IncomeModel toModel(Income income) {
    return IncomeModel(
      id: income.id,
      title: income.title,
      description: income.description,
      amountInPaise: income.amount.amountInPaise,
      createdAtDateTime: income.createdAt.toIso8601String(),
      transactionDateTime: income.transactionDate.toIso8601String(),
      transactionType: transactionTypeToString(income.transactionType),
      transactionCategoryId: income.transactionCategory.categoryId,
      toSourceId: income.toSource.sourceId,
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
