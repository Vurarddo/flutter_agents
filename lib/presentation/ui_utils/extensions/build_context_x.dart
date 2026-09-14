import 'package:flutter/material.dart';

import 'package:flutter_agents/l10n/generated/l10n.dart';
import 'package:flutter_agents/presentation/theme/app_custom_colors.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  S get l10n => S.of(this);

  AppCustomColors get customColors =>
      Theme.of(this).extension<AppCustomColors>() ?? AppCustomColors.light;
}
