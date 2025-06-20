import 'package:equatable/equatable.dart';
import 'package:wallet_repository/src/entities/entities.dart';

class Bank extends Equatable {
  final String bankName;
  final String amount;
  final bool isPrimary;

  const Bank({
    required this.bankName,
    required this.amount,
    required this.isPrimary,
  });

  Bank copyWith({String? bankName, String? amount, bool? isPrimary}) {
    return Bank(
      bankName: bankName ?? this.bankName,
      amount: amount ?? this.amount,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  BankEntitiy toEntity() {
    return BankEntitiy(
      bankName: bankName,
      amount: amount,
      isPrimary: isPrimary,
    );
  }

  Bank fromEntity(BankEntitiy bankEntity) {
    return Bank(
      bankName: bankEntity.bankName,
      amount: bankEntity.amount,
      isPrimary: bankEntity.isPrimary,
    );
  }

  @override
  List<Object?> get props => [bankName, amount, isPrimary];
}
