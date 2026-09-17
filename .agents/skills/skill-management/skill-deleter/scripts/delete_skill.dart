import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty || !args.any((a) => a.startsWith('--name='))) {
    print('Usage: dart run delete_skill.dart --name=<skill-name> [--dry-run]');
    exit(1);
  }

  final dryRun = args.contains('--dry-run');
  final skillName = args
      .firstWhere((a) => a.startsWith('--name='))
      .split('=')[1]
      .trim()
      .toLowerCase();

  print('🗑️  ========================================================');
  print('🗑️  Skill Deleter & Reference Cleaner: $skillName');
  print('🗑️  ========================================================\n');

  final projectDir = Directory.current;
  final skillsDir = Directory('${projectDir.path}/skills');
  final agentsSkillsDir = Directory('${projectDir.path}/.agents/skills');

  // Find skill directories
  final targetDirs = <Directory>[];

  void scan(Directory root) {
    if (!root.existsSync()) return;
    for (final entity in root.listSync(recursive: true)) {
      if (entity is Directory && entity.path.split(Platform.pathSeparator).last == skillName) {
        final skillMd = File('${entity.path}/SKILL.md');
        if (skillMd.existsSync()) {
          targetDirs.add(entity);
        }
      }
    }
  }

  scan(skillsDir);
  scan(agentsSkillsDir);

  if (targetDirs.isEmpty) {
    print('❌ Skill "$skillName" not found in skills/ or .agents/skills/.');
    exit(1);
  }

  print('📁 Found target skill directories:');
  for (final dir in targetDirs) {
    print('   - ${dir.path}');
  }

  // Scan codebase for references
  print('\n🔍 Scanning codebase for references to "$skillName"...');
  final referencingFiles = <File, List<int>>{};

  void searchReferences(Directory dir) {
    if (!dir.existsSync()) return;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File) {
        // Skip target skill files themselves, build, git, etc.
        if (targetDirs.any((td) => entity.path.startsWith(td.path))) continue;
        if (entity.path.contains('/.git/') || entity.path.contains('/build/')) continue;

        try {
          final lines = entity.readAsLinesSync();
          final matchingLines = <int>[];
          for (var i = 0; i < lines.length; i++) {
            if (lines[i].toLowerCase().contains(skillName)) {
              matchingLines.add(i + 1);
            }
          }
          if (matchingLines.isNotEmpty) {
            referencingFiles[entity] = matchingLines;
          }
        } catch (_) {}
      }
    }
  }

  searchReferences(Directory('${projectDir.path}/lib'));
  searchReferences(Directory('${projectDir.path}/.agents'));
  searchReferences(Directory('${projectDir.path}/skills'));

  if (referencingFiles.isNotEmpty) {
    print('⚠️  Found ${referencingFiles.length} file(s) referencing "$skillName":');
    for (final entry in referencingFiles.entries) {
      print('   📄 ${entry.key.path} (lines: ${entry.value.join(", ")})');
    }
  } else {
    print('✅ No active references to "$skillName" found.');
  }

  if (dryRun) {
    print('\n[DRY-RUN] Would delete ${targetDirs.length} director(ies). No files modified.');
    return;
  }

  // Delete skill directories
  print('\n🗑️  Deleting skill directories...');
  for (final dir in targetDirs) {
    dir.deleteSync(recursive: true);
    print('   🗑️ Deleted ${dir.path}');
  }

  // Regenerate documentation portal if doc_generator exists
  var docGenScript = File('${projectDir.path}/.agents/skills/documentation/skill-html-doc-generator/scripts/doc_generator.dart');
  if (!docGenScript.existsSync()) {
    docGenScript = File('${projectDir.path}/skills/documentation/skill-html-doc-generator/scripts/doc_generator.dart');
  }
  if (docGenScript.existsSync()) {
    print('\n🔄 Regenerating documentation portal without "$skillName"...');
    final result = await Process.run('dart', ['run', docGenScript.path]);
    if (result.exitCode == 0) {
      print('   ✅ Documentation portal regenerated successfully.');
    } else {
      print('   ⚠️ Documentation regeneration warning: ${result.stderr}');
    }
  }

  print('\n✅ Skill "$skillName" deleted successfully!');
  if (referencingFiles.isNotEmpty) {
    print('👉 Remember to review and clean remaining references listed above.');
  }
}
