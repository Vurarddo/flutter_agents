---
name: flutter-ui-kit-components
description: Authoring standards and implementation recipes for pure UI Kit components in Flutter. Covers design tokens consumption, buttons, cards, status badges, modal dialogs, bottom sheets, snackbars, and typed variant APIs. Use when creating or updating reusable UI Kit widgets.
---

# Flutter UI Kit Component Authoring Guide

## 1. Overview & When to Apply

Use this skill whenever:
- Implementing reusable atomic widgets (Buttons, Cards, Badges, Chips) in `lib/presentation/ui_kit/`.
- Building reusable modals, bottom sheets, confirmation dialogs, or snackbars.
- Establishing consistent component APIs with typed variants and sizes.
- Handling loading, disabled, hover, and pressed states inside UI Kit widgets.
- Ensuring strict token consumption without hardcoding pixel values or hex colors.

---

## 2. Prerequisites & Related Skills

| Relation | Skill | Purpose |
| :--- | :--- | :--- |
| **Parent UI Kit Hub** | [flutter-ui-kit-hub](../flutter-ui-kit-hub/SKILL.md) | UI Kit architecture, laws, and folder standards. |
| **Widget Previews** | [flutter-ui-kit-preview](../flutter-ui-kit-preview/SKILL.md) | Attaching `@Preview` decorators to components. |
| **Theming Tokens** | [flutter-ui-theme-hub](../../../theme/flutter-ui-theme-hub/SKILL.md) | Accessing ColorScheme, TextTheme, and CustomColors. |
| **Custom Controls** | [flutter-ui-forms-custom-controls](../../forms/flutter-ui-forms-custom-controls/SKILL.md) | Wrapping UI Kit inputs with reactive form bindings. |
| **Marionette Adaptation** | [marionette-custom-widgets](../../../../testing/marionette/marionette-custom-widgets/SKILL.md) | Registering custom interactive widgets in `AppMarionetteConfig`. |

---

## 3. Reference Implementation Recipes (`examples/`)

- **Status & Category Badge (`AppBadge`):** [examples/app_badge_sample.dart](examples/app_badge_sample.dart)
  - Pure stateless badge with typed `AppBadgeVariant` (`primary`, `success`, `warning`, `error`, `neutral`).
- **Interactive Card (`AppCard`):** [examples/app_card_sample.dart](examples/app_card_sample.dart)
  - Supports selection borders, surface tint, and `InkWell` tap callbacks.
- **Confirmation Modals (`AppModals`):** [examples/app_modals_sample.dart](examples/app_modals_sample.dart)
  - Type-safe `showConfirmationDialog` helper honoring M3 design tokens.

---

## 4. Strict UI Kit Architecture Rules

1. **100% Stateless & Pure:** Reusable UI Kit widgets must never inject BLoCs, Cubits, or Repositories directly.
2. **Zero Hardcoded Colors:** All colors must resolve from `context.colorScheme` or custom `ThemeExtension`.
3. **Mandatory `@Preview` Coverage:** Every component file in `lib/presentation/ui_kit/` MUST include top-level `@Preview` functions for both Light and Dark themes wrapped in `PreviewWrapper`.
4. **Marionette & Semantics Registration:** Interactive widgets (buttons, fields, clickable cards) must be registered in `AppMarionetteConfig` (`isInteractiveWidget`, `extractText`) in `lib/infrastructure/config/marionette_config.dart` or wrapped with `Semantics`.

---

## 5. Verification Checklist

- [ ] Widget is pure and stateless with explicit typed properties.
- [ ] Colors and styles derived strictly from `context.colorScheme`, `context.textTheme`, and `context.customColors`.
- [ ] Component is decoupled from domain logic and view models.
- [ ] Dual `@Preview` functions (Light & Dark) provided using `PreviewWrapper`.
- [ ] Interactive custom controls are registered in `AppMarionetteConfig`.
