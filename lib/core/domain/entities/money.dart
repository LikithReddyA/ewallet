import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final int amountInPaise;

  const Money._({required this.amountInPaise});

  factory Money.inRupees(double rupees) {
    final int paise = (rupees * 100).round();
    return Money._(amountInPaise: paise);
  }

  factory Money.inPaise(int paise) {
    return Money._(amountInPaise: paise);
  }

  double get inRupees => amountInPaise / 100;

  Money operator +(Money money) {
    final int total = amountInPaise + money.amountInPaise;
    return Money._(amountInPaise: total);
  }

  Money operator -(Money money) {
    final int total = amountInPaise - money.amountInPaise;
    return Money._(amountInPaise: total);
  }

  @override
  String toString() {
    return '₹ ${inRupees.toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props => [amountInPaise];
}
