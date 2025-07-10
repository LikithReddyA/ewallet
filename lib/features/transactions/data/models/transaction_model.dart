import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int amountInPaise;
  final String createdAtDateTime;
  final String transactionDateTime;
  final String transactionType;
  final String transactionCategory;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.amountInPaise,
    required this.createdAtDateTime,
    required this.transactionDateTime,
    required this.transactionType,
    required this.transactionCategory,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> doc) {
    return TransactionModel(
      id: doc['id'] as String? ?? '',
      title: doc['title'] as String? ?? '',
      description: doc['description'] as String? ?? '',
      amountInPaise: doc['amountInPaise'] as int? ?? 0,
      createdAtDateTime: doc['createdAtDateTime'] as String? ?? '',
      transactionDateTime: doc['transactionDateTime'] as String? ?? '',
      transactionType: doc['transactionType'] as String? ?? '',
      transactionCategory: doc['transactionCategory'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amountInPaise': amountInPaise,
      'createdAtDateTime': createdAtDateTime,
      'transactionDateTime': transactionDateTime,
      'transactionType': transactionType,
      'transactionCategory': transactionCategory,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    amountInPaise,
    createdAtDateTime,
    transactionDateTime,
    transactionType,
    transactionCategory,
  ];
}
