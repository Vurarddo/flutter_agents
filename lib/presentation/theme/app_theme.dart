import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/theme/app_color_scheme.dart';
import 'package:flutter_agents/presentation/theme/app_custom_colors.dart';
import 'package:flutter_agents/presentation/theme/app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: AppColorScheme.light,
        textTheme: AppTextTheme.textTheme,
        extensions: const [AppCustomColors.light],
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColorScheme.dark,
        textTheme: AppTextTheme.textTheme,
        extensions: const [AppCustomColors.dark],
      );
}
