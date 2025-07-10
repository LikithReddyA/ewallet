import 'package:ewallet/core/domain/entities/money.dart';
import 'package:ewallet/features/shared/data/models/source_model.dart';
import 'package:ewallet/features/shared/domain/entities/source.dart';

class SourceMapper {
  static Source toEntity(SourceModel sourceModel) {
    return Source(
      sourceId: sourceModel.sourceId,
      name: sourceModel.name,
      money: Money.inPaise(sourceModel.amountInPaise),
    );
  }

  static SourceModel toModel(Source source) {
    return SourceModel(
      sourceId: source.sourceId,
      name: source.name,
      amountInPaise: source.money.amountInPaise,
    );
  }

  static List<Source> toEntityList(List<SourceModel> models) =>
      models.map(toEntity).toList();

  static List<SourceModel> toModelList(List<Source> entities) =>
      entities.map(toModel).toList();
}
