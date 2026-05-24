import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Money extends Equatable {
  /// Stored in smallest currency unit
  /// Example:
  /// ₹10.50 => 1050
  final int minorUnits;

  const Money(this.minorUnits);

  /// Create from double value
  factory Money.fromDouble(double value) {
    return Money((value * 100).round());
  }

  /// Create from integer rupees
  factory Money.fromInt(int value) {
    return Money(value * 100);
  }

  /// Convert to decimal value
  double get value => minorUnits / 100;

  /// Currency symbol
  String get symbol => '₹';

  /// Formatted with symbol
  String get formatted {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: symbol,
      decimalDigits: 2,
    ).format(value);
  }

  /// Formatted without symbol
  String get formattedValue {
    return NumberFormat('#,##0.00').format(value);
  }

  /// Checks if zero
  bool get isZero => minorUnits == 0;

  /// Checks if positive
  bool get isPositive => minorUnits > 0;

  /// Checks if negative
  bool get isNegative => minorUnits < 0;

  /// Addition
  Money operator +(Money other) {
    return Money(minorUnits + other.minorUnits);
  }

  /// Subtraction
  Money operator -(Money other) {
    return Money(minorUnits - other.minorUnits);
  }

  /// Multiply
  Money multiply(double factor) {
    return Money((minorUnits * factor).round());
  }

  /// Divide
  Money divide(double divisor) {
    return Money((minorUnits / divisor).round());
  }

  /// Compare
  bool operator >(Money other) {
    return minorUnits > other.minorUnits;
  }

  bool operator <(Money other) {
    return minorUnits < other.minorUnits;
  }

  bool operator >=(Money other) {
    return minorUnits >= other.minorUnits;
  }

  bool operator <=(Money other) {
    return minorUnits <= other.minorUnits;
  }

  /// Serialization
  int toJson() => minorUnits;

  factory Money.fromJson(dynamic json) {
    return Money(json as int);
  }

  /// Zero constant
  static const zero = Money(0);

  @override
  String toString() => formatted;

  @override
  List<Object?> get props => [minorUnits];
}
