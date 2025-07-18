import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class ExpenseParams {
  final String expenseId;
  final String title;
  final String? description;
  final Money amount;
  final DateTime transactionDate;
  final Category transactionCategory;
  final TransactionType transactionType;
  final Source fromSource;

  const ExpenseParams({
    required this.expenseId,
    required this.title,
    required this.description,
    required this.amount,
    required this.transactionDate,
    required this.transactionCategory,
    required this.transactionType,
    required this.fromSource,
  });
}
