import 'package:ewallet/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:ewallet/features/settings/data/datasources/theme_local_data_source_impl.dart';
import 'package:ewallet/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:ewallet/features/settings/domain/repositories/theme_repository.dart';
import 'package:ewallet/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:ewallet/features/settings/domain/usecases/save_theme_mode_usecase.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initSettingsDependencies(GetIt sl) async {
  // Datasource
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Repositories
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(themeLocalDataSource: sl()),
  );

  //Usecases
  sl.registerLazySingleton<GetThemeModeUsecase>(
    () => GetThemeModeUsecase(themeRepository: sl()),
  );
  sl.registerLazySingleton<SaveThemeModeUsecase>(
    () => SaveThemeModeUsecase(themeRepository: sl()),
  );

  // Bloc
  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(getThemeModeUsecase: sl(), saveThemeModeUsecase: sl()),
  );
}
