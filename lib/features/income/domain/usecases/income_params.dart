import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/shared/category/domain/entities/category.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class IncomeParams {
  final String userId;
  final String incomeId;
  final String title;
  final String? description;
  final Money amount;
  final DateTime createdAt;
  final DateTime transactionDate;
  final Category transactionCategory;
  final TransactionType transactionType;
  final Source toSource;

  const IncomeParams({
    required this.userId,
    required this.incomeId,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.transactionDate,
    required this.transactionCategory,
    required this.transactionType,
    required this.toSource,
  });
}
