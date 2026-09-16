import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

enum AppBadgeVariant { success, warning, info, primary }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeVariant variant;

  const AppBadge({
    super.key,
    required this.text,
    this.variant = AppBadgeVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, fgColor) = switch (variant) {
      AppBadgeVariant.success => (
        context.customColors.success.withValues(alpha: 0.15),
        context.customColors.success,
      ),
      AppBadgeVariant.warning => (
        context.customColors.warning.withValues(alpha: 0.15),
        context.customColors.warning,
      ),
      AppBadgeVariant.info => (
        context.customColors.info.withValues(alpha: 0.15),
        context.customColors.info,
      ),
      AppBadgeVariant.primary => (
        context.colorScheme.primaryContainer,
        context.colorScheme.onPrimaryContainer,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: fgColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
