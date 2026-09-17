---
name: marionette-hub
description: Primary coordinator and entry point for Marionette MCP and marionette_flutter AI-driven runtime UI interaction, automated smoke testing, and real-time element inspection. Use when connecting agents to running Flutter apps, performing live visual verification, driving interactive test flows, or configuring Marionette for custom design systems.
---

# Marionette Runtime UI Driving & Testing Hub

## 1. Overview & Architectural Role

`marionette-hub` coordinates runtime interaction between AI agents and live running Flutter applications via the Model Context Protocol (MCP). Unlike static analysis or development-time tooling, Marionette enables autonomous agents to:
- Inspect the active widget tree and discover interactive elements (`get_interactive_elements`).
- Programmatically tap buttons, tabs, dialogs, and cards (`tap`).
- Type into text fields and search inputs (`enter_text`).
- Scroll lists, slivers, and carousels (`scroll_to`, `scroll`).
- Capture screen previews and verify visual states (`take_screenshot`).
- Inspect live application logs and diagnostics (`get_logs`).

```mermaid
graph TD
    Agent["AI Agent / Antigravity IDE"] <-->|Model Context Protocol (MCP)| MarionetteMCP["marionette_mcp Server"]
    MarionetteMCP <-->|VM Service Protocol / WebSocket| MarionetteFlutter["marionette_flutter Binding (kDebugMode)"]
    MarionetteFlutter --> FlutterApp["Flutter Runtime Widget Tree & Semantics"]
    
    subgraph "Marionette Skill Mesh"
        Hub["marionette-hub<br/>(Coordinator)"] --> Inter["marionette-interaction<br/>(Actions & MCP Tools)"]
        Hub --> Custom["marionette-custom-widgets<br/>(Design System & Semantics)"]
    end
```

---

## 2. Decision & Routing Matrix

| Scenario / Objective | Target Skill | Key Tools / Actions |
| :--- | :--- | :--- |
| **Executing UI actions, tapping, typing, scrolling, taking screenshots, inspecting logs** | [`marionette-interaction`](../marionette-interaction/SKILL.md) | `get_interactive_elements`, `tap`, `enter_text`, `scroll_to`, `take_screenshot`, `get_logs` |
| **Configuring custom UI Kit widgets, custom buttons/fields, text extraction, Semantics** | [`marionette-custom-widgets`](../marionette-custom-widgets/SKILL.md) | `MarionetteConfiguration`, `isInteractiveWidget`, `extractText`, `Semantics` |
| **End-to-End automated integration tests with `integration_test` package** | [`testing-integration`](../../testing-integration/SKILL.md) | `testWidgets`, `WidgetTester`, CI/CD test runners |
| **Unit, Widget, and BLoC state verification** | [`testing-hub`](../../testing-hub/SKILL.md) | `test`, `testWidgets`, `blocTest` |

---

## 3. Core Architecture & Bootstrap Standards

### 3.1 Zero Production Overhead Standard
`marionette_flutter` bindings MUST only be initialized in `kDebugMode` (or development flavors). Release builds MUST NEVER execute Marionette instrumentation.

```dart
// lib/main.dart
void main() {
  runZonedGuarded(
    () async {
      if (kDebugMode) {
        MarionetteBinding.ensureInitialized(
          AppMarionetteConfig.create(),
        );
      } else {
        WidgetsFlutterBinding.ensureInitialized();
      }

      await configureDependencies();
      runApp(const Application());
    },
    (error, stackTrace) => debugPrint('Error: $error'),
  );
}
```

### 3.2 Design System Compatibility Rule
Standard Material 3 widgets work out of the box. Any custom design system widgets (`AppButton`, `AppTextField`, `AppBadge`, `AppCard`) MUST be registered in `AppMarionetteConfig` in `lib/infrastructure/config/marionette_config.dart`.

---

## 4. Related Skills & Cross-References

- [`marionette-interaction`](../marionette-interaction/SKILL.md) — Tool-level execution runbook.
- [`marionette-custom-widgets`](../marionette-custom-widgets/SKILL.md) — Custom design system registration and Semantics.
- [`flutter-ui-kit-hub`](../../../presentation/ui/ui-kit/flutter-ui-kit-hub/SKILL.md) — UI Kit components and design tokens.
- [`testing-hub`](../../testing-hub/SKILL.md) — Overall testing strategy.
