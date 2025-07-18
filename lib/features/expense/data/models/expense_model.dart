import 'package:ewallet/features/transactions/data/models/transaction_model.dart';

class ExpenseModel extends TransactionModel {
  final String fromSourceId;

  const ExpenseModel({
    required super.id,
    required super.title,
    super.description,
    required super.amountInPaise,
    required super.createdAtDateTime,
    required super.transactionDateTime,
    required super.transactionType,
    required super.transactionCategoryId,
    required this.fromSourceId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> doc) {
    return ExpenseModel(
      id: doc['id'] as String? ?? '',
      title: doc['title'] as String? ?? '',
      description: doc['description'] as String? ?? '',
      amountInPaise: doc['amountInPaise'] as int? ?? 0,
      createdAtDateTime: doc['createdAtDateTime'] as String? ?? '',
      transactionDateTime: doc['transactionDateTime'] as String? ?? '',
      transactionType: doc['transactionType'] as String? ?? '',
      transactionCategoryId: doc['transactionCategoryId'] as String? ?? '',
      fromSourceId: doc['fromSourceId'] as String? ?? '',
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
      'transactionCategoryId': transactionCategoryId,
      'fromSourceId': fromSourceId,
    };
  }

  @override
  List<Object?> get props => [super.props, fromSourceId];
}
