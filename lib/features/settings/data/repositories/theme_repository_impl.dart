import 'package:dartz/dartz.dart';
import 'package:ewallet/core/errors/failure.dart';
import 'package:ewallet/core/errors/failure_handler.dart';
import 'package:ewallet/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeRepositoryImpl({required this.themeLocalDataSource});
  @override
  Future<Either<Failure, AppThemeMode>> getSavedThemeMode() async {
    try {
      final themeModeString = await themeLocalDataSource.getThemeMode();

      final themeMode = themeModeString == null
          ? AppThemeMode.system
          : AppThemeMode.values.byName(themeModeString);
      return Right(themeMode);
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveThemeMode(AppThemeMode appThemeMode) async {
    try {
      await themeLocalDataSource.saveThemeMode(appThemeMode.name);
      return Right(unit);
    } catch (e) {
      return Left(FailureHandler.handle(e));
    }
  }
}
