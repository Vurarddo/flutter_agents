import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/presentation/state_management/theme/hydrated_theme_cubit.mixin.dart';
import 'package:flutter_agents/presentation/state_management/theme/theme_state.dart';

@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeState> with HydratedThemeCubitMixin {
  ThemeCubit() : super(const ThemeState());

  void setThemeMode(AppThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void toggleTheme() {
    final next = switch (state.themeMode) {
      AppThemeMode.system || AppThemeMode.light => AppThemeMode.dark,
      AppThemeMode.dark => AppThemeMode.light,
    };
    emit(state.copyWith(themeMode: next));
  }
}
