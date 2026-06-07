import 'package:dartz/dartz.dart';
import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/domain/repositories/theme_repository.dart';

class SaveThemeModeUsecase extends UseCase<Unit, AppThemeMode> {
  final ThemeRepository themeRepository;

  SaveThemeModeUsecase({required this.themeRepository});
  @override
  Future<Either<Failure, Unit>> call(AppThemeMode apThemeMode) async {
    return await themeRepository.saveThemeMode(apThemeMode);
  }
}
