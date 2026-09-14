import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:flutter_agents/presentation/state_management/theme/theme_state.dart';

mixin HydratedThemeCubitMixin on HydratedMixin<ThemeState> {
  @override
  String get storagePrefix => 'ThemeCubit';

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    try {
      final index = json['themeModeIndex'] as int?;
      return ThemeState(
        themeMode: index != null ? AppThemeMode.values[index] : AppThemeMode.system,
      );
    } catch (_) {
      return const ThemeState(themeMode: AppThemeMode.system);
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {'themeModeIndex': state.themeMode.index};
  }
}
