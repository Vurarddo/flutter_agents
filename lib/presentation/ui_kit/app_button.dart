import 'package:flutter/material.dart';

import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

enum AppButtonVariant { primary, secondary, tonal, outlined, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 48,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: onPressed,
          child: child,
        ),
      AppButtonVariant.secondary => ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      AppButtonVariant.tonal => FilledButton.tonal(
          onPressed: onPressed,
          child: child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: onPressed,
          child: child,
        ),
    };
  }
}
