# Flutter Agents — Operational & Developer Runbook

This runbook provides actionable commands, conventions, and operational instructions for developing and maintaining the `flutter_agents` application.

---

## 1. Multi-Environment Flavors

Every environment is isolated natively (application ID suffixes, bundle IDs, and display names) and configured via `--dart-define-from-file`.

| Flavor | Target Command | Config File |
| :--- | :--- | :--- |
| **Development** | `flutter run --flavor dev --dart-define-from-file=config/env_dev.json` | `config/env_dev.json` |
| **Staging** | `flutter run --flavor stage --dart-define-from-file=config/env_stage.json` | `config/env_stage.json` |
| **Production** | `flutter run --flavor prod --dart-define-from-file=config/env_prod.json` | `config/env_prod.json` |

---

## 2. Code Generation & Quality Toolchain

### 2.1 Full Generation Pipeline
Run when modifying entities (`@freezed`), DTOs (`@JsonSerializable`), API services (`@RestApi`), dependency injection (`@injectable`), or routes (`@RoutePage`):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2.2 Watch Mode (Active Development)
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 2.3 Localization Generation
Run whenever editing `lib/l10n/intl_en.arb` or `lib/l10n/intl_uk.arb`:

```bash
flutter pub run intl_utils:generate
```

### 2.4 Import Sorting
Strict package imports and clean ordering are enforced across the workspace:

```bash
flutter pub run import_sorter:main
```

### 2.5 Cache Cleaning
If generator state becomes corrupted or conflicts occur:

```bash
flutter pub run build_runner clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 3. Automated Testing Runbook

| Test Suite | Command | Purpose |
| :--- | :--- | :--- |
| **All Tests** | `flutter test` | Executes unit, bloc, and widget test suites |
| **Unit Tests** | `flutter test test/unit/` | Pure business logic, UseCases, Mappers |
| **BLoC Tests** | `flutter test test/bloc/` | State management events, transformers, persistence |
| **Widget Tests** | `flutter test test/widget/` | Component rendering, UI Kit isolation |
| **Integration** | `flutter test integration_test/uikit_page_test.dart` | End-to-end UI Kit & Page smoke test |
| **Static Analysis** | `dart analyze . --fatal-infos` | Strict zero-warning quality gate |

---

## 4. Architectural Conventions & Skill Navigation

This project utilizes specialized agent skills located in `.agents/skills/`:

- **Architecture Rules:** [.agents/skills/flutter-clean-architecture/SKILL.md](.agents/skills/flutter-clean-architecture/SKILL.md)
- **Domain & UseCases:** [.agents/skills/domain/domain-usecases/SKILL.md](.agents/skills/domain/domain-usecases/SKILL.md)
- **Entities & Freezed:** [.agents/skills/domain/domain-entities-freezed/SKILL.md](.agents/skills/domain/domain-entities-freezed/SKILL.md)
- **Data & Retrofit:** [.agents/skills/data/data-retrofit-clients/SKILL.md](.agents/skills/data/data-retrofit-clients/SKILL.md)
- **BLoC & Cubit:** [.agents/skills/presentation/state-management/flutter-bloc-core/SKILL.md](.agents/skills/presentation/state-management/flutter-bloc-core/SKILL.md)
- **UI Kit & Showcase:** [.agents/skills/presentation/ui/ui-kit/flutter-ui-kit-components/SKILL.md](.agents/skills/presentation/ui/ui-kit/flutter-ui-kit-components/SKILL.md)
- **Theme & M3:** [.agents/skills/presentation/theme/flutter-ui-theme-hub/SKILL.md](.agents/skills/presentation/theme/flutter-ui-theme-hub/SKILL.md)
- **Flavors & Environments:** [.agents/skills/native/native-flavors-environments/SKILL.md](.agents/skills/native/native-flavors-environments/SKILL.md)
