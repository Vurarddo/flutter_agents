import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/ui_kit/app_badge.dart';
import 'package:flutter_agents/presentation/ui_kit/app_card.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

class UiKitSurfacesSection extends StatelessWidget {
  const UiKitSurfacesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Surfaces & Badges',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clean Architecture Component Card',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pure UI Kit component wrapped in standard theme-driven styling.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 8,
                children: [
                  AppBadge(text: 'SUCCESS', variant: AppBadgeVariant.success),
                  AppBadge(text: 'WARNING', variant: AppBadgeVariant.warning),
                  AppBadge(text: 'INFO', variant: AppBadgeVariant.info),
                  AppBadge(text: 'PRIMARY', variant: AppBadgeVariant.primary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
