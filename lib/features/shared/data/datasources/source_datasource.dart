import 'package:ewallet/features/shared/data/models/source_model.dart';

abstract class SourceDatasource {
  Future<SourceModel> getSourceById(String sourceId, String userId);
}
