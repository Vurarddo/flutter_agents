# Flutter Agents

[![Flutter](https://img.shields.io/badge/Flutter-3.47.3-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.3-teal.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Universal production-grade Flutter application template engineered with **Strict Clean Architecture**, Material 3 design system (#FFDE3F brand seed), multi-environment native Flavors (`dev`, `stage`, `prod`), framework-isolated BLoC/Cubit state management, and an interactive UI Kit showcase.

---

## 🏛 Architecture Overview

Strict separation of concerns across four distinct layers:

```text
lib/
├── core/                                   # Pure Dart utility functions, constants, extensions
├── domain/                                 # Pure Business Logic (Zero Flutter SDK imports)
│   └── example/                            # Entities (Freezed), Failures, Repository Contracts, UseCases
├── data/                                   # Data Layer (DTOs, Retrofit Clients, Repository Implementations)
│   └── example/                            # JSON serialization, API clients, Error mapping
├── infrastructure/                         # Platform & Framework Implementations (Dio, DI, Storage, Logging)
├── l10n/                                   # Application Resource Bundles (ARB) & Generated S class
└── presentation/                           # UI Screens, Widgets, Theme, and BLoC/Cubit
    ├── navigation/                         # Declarative routing with AutoRoute
    ├── pages/                              # Screen widgets (pages/uikit/, pages/example/)
    ├── state_management/                   # Feature BLoCs & Cubits (Framework-isolated)
    ├── theme/                              # Material 3 Dynamic ColorScheme & ThemeExtensions
    ├── ui_kit/                             # Pure reusable UI components (Buttons, Fields, Cards, Badges)
    └── ui_utils/                           # Context & String extensions (BuildContextX, StringX)
```

---

## 🚀 Getting Started

### 1. Prerequisites
- **Flutter SDK**: ^3.47.3 (channel `stable`)
- **Dart SDK**: ^3.13.3
- **Android**: JDK 17, Android Studio, Android SDK Build Tools
- **iOS / macOS**: macOS with Xcode 15+, CocoaPods

### 2. Environment Setup
Local credentials and environment configurations are kept outside Git tracking. Duplicate the template file to configure your local environments:

```bash
cp config/env_template.json config/env_dev.json
cp config/env_template.json config/env_stage.json
cp config/env_template.json config/env_prod.json
```

### 3. Dependencies & Code Generation
```bash
# Install dependencies
flutter pub get

# Generate localization classes
flutter pub run intl_utils:generate

# Generate code (Freezed, Retrofit, Injectable, AutoRoute)
flutter pub run build_runner build --delete-conflicting-outputs

# Format and sort imports
flutter pub run import_sorter:main
```

### 4. Running the Application
Launch with your desired flavor and environment configuration:

```bash
# Development (default)
flutter run --flavor dev --dart-define-from-file=config/env_dev.json

# Staging
flutter run --flavor stage --dart-define-from-file=config/env_stage.json

# Production
flutter run --flavor prod --dart-define-from-file=config/env_prod.json
```

---

## 🧪 Testing

```bash
# Run all automated tests
flutter test

# Run UI Kit integration test
flutter test integration_test/uikit_page_test.dart

# Run static analysis
dart analyze . --fatal-infos
```

---

## 🤖 Installing Skills via `dart run skills@`

You can install all 110+ production AI agent skills from this repository directly into any of your Dart or Flutter projects using the official [Dart Package Skills](https://dart.dev/ai/package-skills) CLI:

```bash
# Install all skills for Antigravity:
dart run skills@ add https://github.com/Vurarddo/flutter_agents --all --agent antigravity

# Install all skills for Cursor:
dart run skills@ add https://github.com/Vurarddo/flutter_agents --all --agent cursor

# Install all skills for Claude:
dart run skills@ add https://github.com/Vurarddo/flutter_agents --all --agent claude

# Interactively select specific skills:
dart run skills@ add https://github.com/Vurarddo/flutter_agents
```


---

## 📖 Operational Runbook
For complete day-to-day developer operations, generator commands, flavor setups, and architecture skill navigation, refer to [RUNBOOK.md](RUNBOOK.md).
