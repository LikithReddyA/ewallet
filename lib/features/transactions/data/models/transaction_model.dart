import 'package:equatable/equatable.dart';

abstract class TransactionModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int amountInPaise;
  final String createdAtDateTime;
  final String transactionDateTime;
  final String transactionType;
  final String transactionCategoryId;

  const TransactionModel({
    required this.id,
    required this.title,
    this.description,
    required this.amountInPaise,
    required this.createdAtDateTime,
    required this.transactionDateTime,
    required this.transactionType,
    required this.transactionCategoryId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    amountInPaise,
    createdAtDateTime,
    transactionDateTime,
    transactionType,
    transactionCategoryId,
  ];
}
