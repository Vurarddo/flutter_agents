---
name: marionette-custom-widgets
description: Architecture, checklist, and recipes for adapting custom Flutter design systems (UI Kit, custom buttons, text fields, canvas badges, clickable cards) to work seamlessly with Marionette MCP using MarionetteConfiguration, isInteractiveWidget, extractText, and Semantics wrappers.
---

# Adapting Custom Design Systems for Marionette MCP

## 1. The Custom Design System Challenge

While standard Flutter Material 3 widgets (`ElevatedButton`, `TextField`, `InkWell`) work out of the box with Marionette MCP, **custom design systems require explicit configuration**. Without configuration:
- AI agents cannot see custom buttons/cards in `get_interactive_elements`.
- Text matching (`tap(text: "...")` or `scroll_to(text: "...")`) fails because display text cannot be extracted from custom widget classes.
- Custom Canvas or graphical elements remain completely invisible.

---

## 2. Production Setup Checklist

Whenever adding or modifying UI Kit components in `lib/presentation/ui_kit/`:

| Symptom | Cause | Solution |
| :--- | :--- | :--- |
| Custom buttons/controls do not appear in `get_interactive_elements` | The widget class type is not recognized as interactive | Add the widget type to `isInteractiveWidget` in `AppMarionetteConfig`. |
| `tap(text:)` or `scroll_to(text:)` cannot find custom controls by text | Text is not being extracted from the widget body | Implement an extraction clause in `extractText` in `AppMarionetteConfig`. |
| Canvas-painted graphics, badges, or custom icons are invisible to the agent | No `Text` or `Semantics` widget in the render tree | Wrap the widget with `Semantics(button: true, label: '...', child: ...)`. |

---

## 3. Centralized Configuration Pattern (`AppMarionetteConfig`)

All custom widget adaptations are consolidated in `lib/infrastructure/config/marionette_config.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

import 'package:agentic_os/presentation/ui_kit/app_badge.dart';
import 'package:agentic_os/presentation/ui_kit/app_button.dart';
import 'package:agentic_os/presentation/ui_kit/app_card.dart';
import 'package:agentic_os/presentation/ui_kit/app_text_field.dart';

abstract final class AppMarionetteConfig {
  static MarionetteConfiguration create() {
    return const MarionetteConfiguration(
      isInteractiveWidget: isInteractiveWidget,
      extractText: extractText,
    );
  }

  static bool isInteractiveWidget(Type type) {
    return type == AppButton ||
        type == AppTextField ||
        type == AppCard;
  }

  static String? extractText(Element element) {
    final widget = element.widget;

    if (widget is AppButton) {
      return widget.label;
    }

    if (widget is AppTextField) {
      final text = widget.controller?.text;
      if (text != null && text.isNotEmpty) return text;
      return widget.label ?? widget.hint;
    }

    if (widget is AppBadge) {
      return widget.text;
    }

    return null;
  }
}
```

---

## 4. Semantics Wrapper Guidelines for Complex & Custom Paint Widgets

For widgets drawn via `CustomPainter` or composite gesture areas, embed standard Flutter `Semantics`:

```dart
class CustomDrawingControl extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomDrawingControl({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(painter: _ControlPainter()),
      ),
    );
  }
}
```

---

## 5. Related Skills

- [`marionette-hub`](../marionette-hub/SKILL.md) — Primary entry point.
- [`marionette-interaction`](../marionette-interaction/SKILL.md) — Operational recipes.
- [`flutter-ui-kit-components`](../../../presentation/ui/ui-kit/flutter-ui-kit-components/SKILL.md) — UI Kit standards.
