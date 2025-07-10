import 'package:equatable/equatable.dart';

class SourceModel extends Equatable {
  final String sourceId;
  final String name;
  final int amountInPaise;

  const SourceModel({
    required this.sourceId,
    required this.name,
    required this.amountInPaise,
  });

  factory SourceModel.fromJson(Map<String, dynamic> doc) {
    return SourceModel(
      sourceId: doc['sourceId'] as String? ?? '',
      name: doc['name'] as String? ?? '',
      amountInPaise: doc['amountInPaise'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sourceId': sourceId, 'name': name, 'amountInPaise': amountInPaise};
  }

  @override
  List<Object?> get props => [sourceId, name, amountInPaise];
}
