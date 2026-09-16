import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/state_management/theme/theme_state.dart';

extension AppThemeModeX on AppThemeMode {
  ThemeMode toFlutter() => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}
