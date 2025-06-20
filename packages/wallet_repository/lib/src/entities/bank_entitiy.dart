import 'package:equatable/equatable.dart';

class BankEntitiy extends Equatable {
  final String bankName;
  final String amount;
  final bool isPrimary;

  const BankEntitiy({
    required this.bankName,
    required this.amount,
    required this.isPrimary,
  });

  Map<String, Object> toDocument() {
    return {'bankName': bankName, 'amount': amount, 'isPrimary': isPrimary};
  }

  BankEntitiy fromDocument(Map<String, dynamic> doc) {
    return BankEntitiy(
      bankName: doc['bankName'],
      amount: doc['amount'],
      isPrimary: doc['isPrimary'],
    );
  }

  @override
  List<Object?> get props => [bankName, amount, isPrimary];
}
