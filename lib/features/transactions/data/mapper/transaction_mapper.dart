import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';
import 'package:ewallet/features/transactions/data/models/transaction_model.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class TransactionMapper {
  static Transaction toEntity(
    TransactionModel transactionModel,
    Category transactionCategory,
  ) {
    return Transaction(
      id: transactionModel.id,
      title: transactionModel.title,
      description: transactionModel.description,
      amount: Money.inPaise(transactionModel.amountInPaise),
      createdAt: DateTime.parse(transactionModel.createdAtDateTime),
      transactionDate: DateTime.parse(transactionModel.transactionDateTime),
      transactionType: stringToTransactionType(
        transactionModel.transactionType,
      ),
      transactionCategory: transactionCategory,
    );
  }

  static TransactionModel toModel(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      title: transaction.title,
      description: transaction.description,
      amountInPaise: transaction.amount.amountInPaise,
      createdAtDateTime: transaction.createdAt.toIso8601String(),
      transactionDateTime: transaction.transactionDate.toIso8601String(),
      transactionType: transactionTypeToString(transaction.transactionType),
      transactionCategory: transaction.transactionCategory.categoryId,
    );
  }

  static TransactionType stringToTransactionType(String transactionType) {
    return TransactionType.values.firstWhere(
      (e) => e.name == transactionType,
      orElse: () => TransactionType.expense,
    );
  }

  static String transactionTypeToString(TransactionType transactionType) =>
      transactionType.name;
}
