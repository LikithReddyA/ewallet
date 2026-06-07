import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/domain/repositories/theme_repository.dart';

class GetThemeModeUsecase extends UseCase<AppThemeMode, NoParams> {
  final ThemeRepository themeRepository;

  GetThemeModeUsecase({required this.themeRepository});
  @override
  Future<Either<Failure, AppThemeMode>> call(NoParams params) async {
    return themeRepository.getSavedThemeMode();
  }
}
