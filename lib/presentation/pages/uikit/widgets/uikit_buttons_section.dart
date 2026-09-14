import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/ui_kit/app_button.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

class UiKitButtonsSection extends StatelessWidget {
  const UiKitButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons & Actions',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AppButton(
              label: 'Primary',
              onPressed: () {},
            ),
            AppButton(
              label: 'Secondary',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
            AppButton(
              label: 'Tonal',
              variant: AppButtonVariant.tonal,
              onPressed: () {},
            ),
            AppButton(
              label: 'Outlined',
              variant: AppButtonVariant.outlined,
              onPressed: () {},
            ),
            AppButton(
              label: 'Text',
              variant: AppButtonVariant.text,
              onPressed: () {},
            ),
            const AppButton(
              label: 'Loading',
              isLoading: true,
            ),
          ],
        ),
      ],
    );
  }
}
