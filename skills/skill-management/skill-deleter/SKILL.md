---
name: skill-deleter
description: Safely deletes an agent skill from the repository, removes all cross-references across AGENTS.md, workflows, and other skills, cleans up routing tables, regenerates documentation via doc_generator.dart, and verifies project integrity. Trigger via slash command /v-delete-skill. Use when asked to delete, uninstall, purge, or remove an agent skill.
---

# Skill Deleter & Reference Cleaner

## 1. Overview & Deletion Safeguards

When removing an AI skill from a project, simply deleting the folder is not enough:
- Stale links and dead references in other skills or `AGENTS.md` cause broken navigation ("stale pointers").
- The HTML documentation portal (`.agents/index.html`) still displays the removed skill unless re-generated.
- AI agents may still attempt to route tasks to non-existent skills if routing matrices are not cleaned.

This skill provides a zero-leakage, safe removal procedure for any skill in the workspace.

---

## 2. End-to-End Deletion Workflow

When invoked via `/v-delete-skill` or requested by the user:

### Step 1: Identify Target Skill & Scan References
Identify the skill name to delete (e.g., `project-advisor` or `my-custom-skill`). Run a dry-run scan using the automated cleanup utility:

```bash
dart run skills/skill-management/skill-deleter/scripts/delete_skill.dart --name=<skill-name> --dry-run
```

The script locates the skill directory in both `skills/` and `.agents/skills/` and reports all files referencing it.

### Step 2: Delete Skill Folders
Execute the deletion script:
```bash
dart run skills/skill-management/skill-deleter/scripts/delete_skill.dart --name=<skill-name>
```

This automatically:
1. Deletes `skills/**/<skill-name>` and `.agents/skills/**/<skill-name>`.
2. Triggers `doc_generator.dart` to rebuild `.agents/index.html` without the deleted skill.

### Step 3: Scrub Cross-References
Review the referenced files reported by Step 1:
1. **`AGENTS.md` / `GEMINI.md`:** Remove skill mentions from Skill Routing tables or rule guidelines.
2. **Other Skills (`SKILL.md`):** Remove dependencies, routing links, or checklist items pointing to the deleted skill.
3. **Workflows (`.agents/workflows/`):** Delete corresponding slash-command workflow files if any existed for this skill.

### Step 4: Re-Generate HTML Documentation
Ensure all HTML landing pages are in sync:
```bash
dart run skills/documentation/skill-html-doc-generator/scripts/doc_generator.dart
```

### Step 5: Verify Quality Gate & Tests
Ensure the removal introduced no breaking changes or broken dependencies:
```bash
dart analyze --fatal-infos
flutter test
```

---

## 3. Anti-Patterns (Strictly Prohibited)

| Anti-Pattern | Severity | Corrective Action |
| :--- | :--- | :--- |
| Deleting a skill folder without cleaning references in `AGENTS.md` | **CRITICAL** | A stale pointer is worse than no pointer. Always scrub references immediately. |
| Forgetting to remove the skill from `.agents/index.html` | **HIGH** | Always run `doc_generator.dart` after deletion. |
| Deleting skills without verifying `dart analyze` passes | **HIGH** | Run static analysis to catch broken code references. |

---

## 4. Verification Checklist

- [ ] Skill directory deleted from `skills/` and `.agents/skills/`.
- [ ] No occurrences of `<skill-name>` remain in `AGENTS.md` or other skills.
- [ ] Documentation portal `.agents/index.html` regenerated without errors.
- [ ] `dart analyze --fatal-infos` passes cleanly.
- [ ] `flutter test` passes 100%.
