import 'package:ewallet/core/domain/entities/money.dart';
import 'package:intl/intl.dart';

extension MoneyFormatting on Money {
  String format() {
    final formatter = NumberFormat.currency(
      locale: "en_IN",
      symbol: "₹ ",
      decimalDigits: 2,
    );
    return formatter.format(inRupees);
  }
}
