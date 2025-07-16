import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/usecases/usecase.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:ewallet/features/shared/source/domain/repositories/source_repository.dart';

class GetSourcesUsecase extends Usecase<List<Source>, NoParams> {
  final SourceRepository sourceRepository;

  GetSourcesUsecase({required this.sourceRepository});
  @override
  Future<Either<Failure, List<Source>>> call(NoParams params) async {
    return await sourceRepository.getAllSources();
  }
}
