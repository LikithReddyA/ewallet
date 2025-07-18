import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class Expense extends Transaction {
  final Source fromSource;

  const Expense({
    required super.id,
    required super.title,
    super.description,
    required super.amount,
    required super.createdAt,
    required super.transactionDate,
    required super.transactionCategory,
    required super.transactionType,
    required this.fromSource,
  });

  @override
  List<Object?> get props => [super.props, fromSource];
}
