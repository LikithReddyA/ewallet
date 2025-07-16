import 'package:ewallet/features/shared/source/data/models/source_model.dart';

abstract class SourceDatasource {
  Future<SourceModel> getSourceById(String sourceId, String userId);
  Future<void> addSource(SourceModel source, String userId);
  Future<List<SourceModel>> getAllSources(String userId);
  Future<void> addBalance(String userId, String sourceId, int amountInPaise);
  Future<void> subtractBalance(
    String userId,
    String sourceId,
    int amountInPaise,
  );
}
