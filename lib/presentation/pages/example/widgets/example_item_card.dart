import 'package:flutter/material.dart';

import 'package:flutter_agents/domain/example/entities/example_item.dart';
import 'package:flutter_agents/presentation/ui_kit/app_badge.dart';
import 'package:flutter_agents/presentation/ui_kit/app_card.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

class ExampleItemCard extends StatelessWidget {
  final ExampleItem item;

  const ExampleItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppBadge(
                text: item.isActive ? 'ACTIVE' : 'INACTIVE',
                variant: item.isActive
                    ? AppBadgeVariant.success
                    : AppBadgeVariant.warning,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
