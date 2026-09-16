---
description: Update skills from remote repository and intelligently synchronize AGENTS.md and AI agent rule files without breaking existing logic.
---

# /v-update-skills

Synchronize agent skills and safely merge upstream `AGENTS.md` and AI rules with local project configurations.

## Quick Trigger Guide:
- Runs `dart run skills@ get --git https://github.com/Vurarddo/flutter_agents` to pull latest skills.
- Executes intelligent non-destructive section merge of `AGENTS.md` (preserving project name, package imports, and custom rules).
- Propagates critical architectural standards (Pre-Push Quality Gate, Freezed 3+, BLoC rules) across all active AI assistant configurations (`AGENTS.md`, `CLAUDE.md`, `.cursorrules`, etc.).
- Follows the instructions defined in `.agents/skills/skill-management/skill-updater/SKILL.md`.
