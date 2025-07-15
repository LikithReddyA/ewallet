import 'package:ewallet/features/shared/domain/entities/source.dart';
import 'package:ewallet/features/transactions/domain/entities/transaction.dart';

class Income extends Transaction {
  final Source toSource;

  const Income({
    required super.id,
    required super.title,
    super.description,
    required super.amount,
    required super.createdAt,
    required super.transactionDate,
    required super.transactionCategory,
    required super.transactionType,
    required this.toSource,
  });

  @override
  List<Object?> get props => [super.props, toSource];
}
