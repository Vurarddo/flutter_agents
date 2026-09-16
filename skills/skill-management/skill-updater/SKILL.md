---
name: skill-updater
description: Executes `dart run skills@ get --git https://github.com/Vurarddo/flutter_agents` to update agent skills and intelligently synchronizes `AGENTS.md` and AI agent rule files without breaking existing logic, local language settings, or project-specific configurations. Trigger via slash command /v-update-skills. Use when updating skills from upstream or synchronizing AI agent rules.
---

# Skill Updater — AI Skills & Rules Synchronizer

## 1. Overview & Why This Skill Exists

When updating skills using Dart's package skills manager:
```bash
dart run skills@ get --git https://github.com/Vurarddo/flutter_agents
```
the CLI tool downloads or updates skill directories in `.agents/skills/`. 

**The Critical Architectural Problem:**
- `package:skills` **only** updates skill folders — it does **NOT** update the central AI rules files (`AGENTS.md`, `CLAUDE.md`, `.cursorrules`, etc.).
- Upstream updates frequently introduce critical quality gates (such as the **Mandatory Pre-Push Quality Gate**, Freezed 3+ constructor rules, and strict BLoC boundaries).
- However, simply overwriting `AGENTS.md` would destroy the user's project name, package imports, local language configurations, and custom domain rules.

This skill automates the complete synchronization flow: it updates package skills, intelligently merges upstream `AGENTS.md` sections without breaking existing logic, and adapts package imports to the target project.

---

## 2. End-to-End Synchronization Workflow

When invoked via `/v-update-skills` or requested by the user:

### Step 1: Update Skills via `package:skills`
Run the skills update command to fetch the latest skill definitions from the repository:
```bash
dart run skills@ get --git https://github.com/Vurarddo/flutter_agents
```
*(If the repository is not yet tracked locally, run `dart run skills@ add https://github.com/Vurarddo/flutter_agents --all --agent antigravity`)*

### Step 2: Intelligently Synchronize `AGENTS.md` & AI Rules
Run the dedicated sync engine script:
```bash
dart run skills/skill-management/skill-updater/scripts/sync_agents_rules.dart
```

To preview changes before applying them without writing to disk:
```bash
dart run skills/skill-management/skill-updater/scripts/sync_agents_rules.dart --dry-run
```

### Step 3: Multi-AI Synchronization (Claude, Cursor, Copilot)
The sync engine automatically checks for existing AI configurations:
- **Antigravity / Generic:** `.agents/AGENTS.md` (or root `AGENTS.md`)
- **Claude Code:** `CLAUDE.md`
- **Cursor:** `.cursorrules` / `.cursor/rules/`
- **GitHub Copilot:** `.github/copilot-instructions.md`

### Step 4: Verify Quality Gates & Test Suite
After synchronization, verify that the project is completely intact:
```bash
dart analyze --fatal-infos
flutter test
```

---

## 3. Intelligent Non-Destructive Merging Rules

The sync engine follows strict non-destructive merge heuristics:

| Aspect | Upstream Behavior | Local Merge Action |
| :--- | :--- | :--- |
| **Package Imports** | References `package:flutter_template/` | Automatically replaced with target project's package name from `pubspec.yaml`. |
| **Language Config** | Default template language | **Preserved:** If local project has configured Ukrainian, English, or custom `.agents/rules/local_language.md`, it is NEVER overwritten. |
| **Mandatory Rules** | Pre-Push Quality Gate, Freezed 3+, BLoC standards | **Injected:** Ensures target project receives the latest security & quality gates. |
| **Skill Routing Matrix** | Latest table of available skills | **Updated:** Reflects newly added skills in the project. |
| **Custom User Sections** | Not present upstream | **100% Preserved:** Any custom `## ` sections added by the developer are kept intact. |
| **Safety Backup** | — | Creates `.agents/AGENTS.md.bak` before making changes. |

---

## 4. Verification Checklist

- [ ] `dart run skills@ get --git https://github.com/Vurarddo/flutter_agents` completed successfully.
- [ ] Safety backup `.agents/AGENTS.md.bak` created.
- [ ] Target package name in imports matches `pubspec.yaml`.
- [ ] Local communication language setting preserved.
- [ ] Mandatory Pre-Push Quality Gate present in Section 12.
- [ ] `dart analyze --fatal-infos` passes with 0 diagnostics.
- [ ] `flutter test` passes 100% of tests.
