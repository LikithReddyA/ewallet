import 'package:equatable/equatable.dart';
import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/shared/domain/entities/category.dart';

enum TransactionType { income, expense, transfer }

class Transaction extends Equatable {
  final String id;
  final String title;
  final String? description;
  final Money amount;
  final DateTime createdAt;
  final DateTime transactionDate;
  final Category transactionCategory;
  final TransactionType transactionType;

  const Transaction({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.transactionDate,
    required this.transactionCategory,
    required this.transactionType,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    amount,
    createdAt,
    transactionDate,
    transactionCategory,
    transactionType,
  ];
}
