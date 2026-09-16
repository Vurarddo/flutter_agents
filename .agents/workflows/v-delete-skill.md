---
description: Safely delete an agent skill from the repository, clean cross-references, and update documentation.
---

# /v-delete-skill

Safely delete an agent skill from `skills/` and `.agents/skills/`, scrub cross-references, and re-generate the documentation portal.

## Quick Trigger Guide:
- Runs `dart run skills/skill-management/skill-deleter/scripts/delete_skill.dart --name=<skill-name>`.
- Scrubs references from `AGENTS.md` and related skills.
- Re-generates documentation portal `.agents/index.html`.
- Follows instructions defined in `.agents/skills/skill-management/skill-deleter/SKILL.md`.
