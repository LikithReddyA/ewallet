import 'package:ewallet/core/common/base/base_usecase.dart';
import 'package:ewallet/features/settings/domain/entities/app_theme_mode.dart';
import 'package:ewallet/features/settings/domain/usecases/get_theme_mode_usecase.dart';
import 'package:ewallet/features/settings/domain/usecases/save_theme_mode_usecase.dart';
import 'package:ewallet/features/settings/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GetThemeModeUsecase getThemeModeUsecase;
  final SaveThemeModeUsecase saveThemeModeUsecase;
  ThemeCubit({
    required this.getThemeModeUsecase,
    required this.saveThemeModeUsecase,
  }) : super(const ThemeState(themeMode: AppThemeMode.system));

  Future<void> loadTheme() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getThemeModeUsecase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (appThemeMode) {
        emit(state.copyWith(themeMode: appThemeMode, isLoading: false));
      },
    );
  }

  Future<void> saveTheme(AppThemeMode themeMode) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await saveThemeModeUsecase(themeMode);
    result.fold((failure) {
      emit(state.copyWith(isLoading: false, errorMessage: failure.message));
    }, (_) => emit(state.copyWith(themeMode: themeMode, isLoading: false)));
  }
}
