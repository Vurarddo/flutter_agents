import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_agents/infrastructure/config/app_config.dart';
import 'package:flutter_agents/presentation/state_management/theme/theme_cubit.dart';
import 'package:flutter_agents/presentation/state_management/theme/theme_state.dart';
import 'package:flutter_agents/presentation/ui_kit/app_badge.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

class UiKitHeaderSection extends StatelessWidget {
  const UiKitHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConfig.appName,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.l10n.uikitTitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            AppBadge(
              text: AppConfig.appEnvRaw.toUpperCase(),
              variant: AppConfig.isProd
                  ? AppBadgeVariant.success
                  : AppConfig.isStage
                  ? AppBadgeVariant.warning
                  : AppBadgeVariant.info,
            ),
          ],
        ),
        const SizedBox(height: 16),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return SegmentedButton<AppThemeMode>(
              segments: [
                ButtonSegment(
                  value: AppThemeMode.system,
                  label: Text(context.l10n.themeModeSystem),
                  icon: const Icon(Icons.brightness_auto),
                ),
                ButtonSegment(
                  value: AppThemeMode.light,
                  label: Text(context.l10n.themeModeLight),
                  icon: const Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: AppThemeMode.dark,
                  label: Text(context.l10n.themeModeDark),
                  icon: const Icon(Icons.dark_mode),
                ),
              ],
              selected: {state.themeMode},
              onSelectionChanged: (selection) {
                context.read<ThemeCubit>().setThemeMode(selection.first);
              },
            );
          },
        ),
      ],
    );
  }
}
