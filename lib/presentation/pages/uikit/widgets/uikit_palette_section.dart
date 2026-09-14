import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

class UiKitPaletteSection extends StatelessWidget {
  const UiKitPaletteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final swatches = [
      ('Primary', context.colorScheme.primary, context.colorScheme.onPrimary),
      ('Secondary', context.colorScheme.secondary, context.colorScheme.onSecondary),
      ('Tertiary', context.colorScheme.tertiary, context.colorScheme.onTertiary),
      ('Surface', context.colorScheme.surface, context.colorScheme.onSurface),
      ('Success', context.customColors.success, Colors.white),
      ('Warning', context.customColors.warning, Colors.white),
      ('Info', context.customColors.info, Colors.white),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Palette (#FFDE3F M3)',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: swatches.map((item) {
            return Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.$2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colorScheme.outlineVariant),
              ),
              child: Text(
                item.$1,
                style: context.textTheme.labelSmall?.copyWith(
                  color: item.$3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
