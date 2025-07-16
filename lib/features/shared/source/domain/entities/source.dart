import 'package:equatable/equatable.dart';
import 'package:ewallet/core/domain/entities/money.dart';

class Source extends Equatable {
  final String sourceId;
  final String name;
  final Money money;

  const Source({
    required this.sourceId,
    required this.name,
    required this.money,
  });

  @override
  List<Object?> get props => [sourceId, name, money];
}
