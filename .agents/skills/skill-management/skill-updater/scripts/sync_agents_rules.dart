import 'dart:convert';
import 'dart:io';

const defaultUpstreamUrl =
    'https://raw.githubusercontent.com/Vurarddo/flutter_agents/main/.agents/AGENTS.md';

void main(List<String> args) async {
  final dryRun = args.contains('--dry-run');
  String? customUpstreamUrl;
  String? customTarget;

  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--upstream-url' && i + 1 < args.length) {
      customUpstreamUrl = args[i + 1];
    } else if (args[i] == '--target' && i + 1 < args.length) {
      customTarget = args[i + 1];
    }
  }

  print('🔄 ========================================================');
  print('🔄 AGENTS.md & AI Rules Intelligent Sync Engine');
  print('🔄 ========================================================\n');

  final projectDir = Directory.current;
  final pubspecFile = File('${projectDir.path}/pubspec.yaml');
  String packageName = 'flutter_template';

  if (pubspecFile.existsSync()) {
    final lines = pubspecFile.readAsLinesSync();
    for (final line in lines) {
      if (line.trim().startsWith('name:')) {
        packageName = line.split(':')[1].trim();
        break;
      }
    }
    print('📦 Detected local package name: $packageName');
  } else {
    print('⚠️ pubspec.yaml not found in current directory. Using default.');
  }

  // Locate local AGENTS.md
  File? targetFile;
  if (customTarget != null) {
    targetFile = File(customTarget);
  } else {
    final candidate1 = File('${projectDir.path}/.agents/AGENTS.md');
    final candidate2 = File('${projectDir.path}/AGENTS.md');
    if (candidate1.existsSync()) {
      targetFile = candidate1;
    } else if (candidate2.existsSync()) {
      targetFile = candidate2;
    } else {
      // Create at .agents/AGENTS.md
      targetFile = candidate1;
    }
  }

  print('🎯 Target rules file: ${targetFile.path}');

  // Fetch upstream AGENTS.md
  final upstreamUrl = customUpstreamUrl ?? defaultUpstreamUrl;
  print('🌐 Fetching upstream canonical rules from: $upstreamUrl ...');

  String upstreamContent;
  try {
    upstreamContent = await fetchUrl(upstreamUrl);
    print('   ✅ Successfully fetched upstream AGENTS.md (${upstreamContent.length} bytes)');
  } catch (e) {
    print('   ⚠️ Network fetch failed: $e');
    final fallbackLocal = File('${projectDir.path}/.agents/AGENTS.md');
    if (fallbackLocal.existsSync() && targetFile.path != fallbackLocal.path) {
      print('   📂 Falling back to local template: ${fallbackLocal.path}');
      upstreamContent = fallbackLocal.readAsStringSync();
    } else {
      print('   ❌ Could not obtain upstream rules. Aborting.');
      exit(1);
    }
  }

  // If local file does not exist, write adapted upstream directly
  if (!targetFile.existsSync()) {
    print('📄 Local AGENTS.md does not exist. Initializing fresh rules file...');
    final adapted = adaptContent(upstreamContent, packageName);
    if (!dryRun) {
      targetFile.parent.createSync(recursive: true);
      targetFile.writeAsStringSync(adapted);
      print('✅ Initialized ${targetFile.path}');
    } else {
      print('[DRY-RUN] Would create ${targetFile.path}');
    }
    return;
  }

  // Local file exists: perform non-destructive section merge
  final localContent = targetFile.readAsStringSync();
  print('🔍 Analyzing local rules against upstream...');

  final mergedContent = mergeRules(
    localContent: localContent,
    upstreamContent: upstreamContent,
    packageName: packageName,
  );

  if (mergedContent.trim() == localContent.trim()) {
    print('✨ Local AGENTS.md is already up to date with upstream rules. No changes needed.');
  } else {
    if (!dryRun) {
      final backupFile = File('${targetFile.path}.bak');
      targetFile.copySync(backupFile.path);
      print('💾 Created safety backup at: ${backupFile.path}');

      targetFile.writeAsStringSync(mergedContent);
      print('✅ Successfully synchronized and updated ${targetFile.path}!');
    } else {
      print('[DRY-RUN] Changes detected. Would update ${targetFile.path}');
    }
  }

  // Also check other AI agent files
  syncOtherAiFiles(projectDir, packageName, dryRun);

  print('\n🛡️  All AI rules synchronized successfully!');
}

Future<String> fetchUrl(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode != 200) {
      throw Exception('HTTP error ${response.statusCode}');
    }
    return await response.transform(utf8.decoder).join();
  } finally {
    client.close();
  }
}

String adaptContent(String content, String packageName) {
  return content
      .replaceAll('package:flutter_template/', 'package:$packageName/')
      .replaceAll('package:flutter_agents/', 'package:$packageName/');
}

Map<String, String> parseSections(String markdown) {
  final sections = <String, String>{};
  final lines = LineSplitter.split(markdown).toList();
  String currentSection = '__header__';
  final currentLines = <String>[];

  for (final line in lines) {
    if (line.startsWith('## ')) {
      if (currentLines.isNotEmpty) {
        sections[currentSection] = currentLines.join('\n');
        currentLines.clear();
      }
      currentSection = line.substring(3).trim();
    }
    currentLines.add(line);
  }

  if (currentLines.isNotEmpty) {
    sections[currentSection] = currentLines.join('\n');
  }

  return sections;
}

String mergeRules({
  required String localContent,
  required String upstreamContent,
  required String packageName,
}) {
  final localSections = parseSections(localContent);
  final upstreamSections = parseSections(adaptContent(upstreamContent, packageName));

  final merged = StringBuffer();

  // 1. Process header
  merged.writeln(upstreamSections['__header__'] ?? localSections['__header__'] ?? '# Antigravity IDE Rules');
  merged.writeln();

  // 2. Iterate through upstream sections and merge
  final processedLocalKeys = <String>{'__header__'};

  for (final entry in upstreamSections.entries) {
    final sectionTitle = entry.key;
    if (sectionTitle == '__header__') continue;

    // Look for matching local section
    String? matchingLocalKey;
    for (final localKey in localSections.keys) {
      if (_isMatchingSection(localKey, sectionTitle)) {
        matchingLocalKey = localKey;
        break;
      }
    }

    if (matchingLocalKey != null) {
      processedLocalKeys.add(matchingLocalKey);
      final localSecContent = localSections[matchingLocalKey]!;
      final upstreamSecContent = entry.value;

      final mergedSec = _mergeSection(
        sectionTitle: sectionTitle,
        localSec: localSecContent,
        upstreamSec: upstreamSecContent,
      );
      merged.writeln(mergedSec);
      merged.writeln('\n---\n');
    } else {
      // New upstream section added
      print('   ➕ Adding new upstream section: $sectionTitle');
      merged.writeln(entry.value);
      merged.writeln('\n---\n');
    }
  }

  // 3. Preserve custom local sections that do not exist upstream
  for (final entry in localSections.entries) {
    final localKey = entry.key;
    if (!processedLocalKeys.contains(localKey)) {
      print('   🔒 Preserving custom project-specific section: $localKey');
      merged.writeln(entry.value);
      merged.writeln('\n---\n');
    }
  }

  return merged.toString().trim() + '\n';
}

bool _isMatchingSection(String a, String b) {
  if (a == b) return true;
  // Match by number prefix e.g. "1. " or "2. " or by key words
  final normA = _normalizeSectionTitle(a);
  final normB = _normalizeSectionTitle(b);
  return normA == normB;
}

String _normalizeSectionTitle(String title) {
  // Extract number prefix if any
  final match = RegExp(r'^(\d+)\.').firstMatch(title.trim());
  if (match != null) {
    return 'sec_${match.group(1)}';
  }
  return title.trim().toLowerCase();
}

String _mergeSection({
  required String sectionTitle,
  required String localSec,
  required String upstreamSec,
}) {
  // Special handling for Section 1 (Language Configuration)
  if (sectionTitle.contains('General Communication & Language')) {
    // Preserve local communication language setting if already configured
    final langMatch = RegExp(r'- \*\*Configured Communication Language:\*\* (.+)').firstMatch(localSec);
    if (langMatch != null) {
      final configuredLang = langMatch.group(1);
      return upstreamSec.replaceAll(
        RegExp(r'- \*\*Configured Communication Language:\*\* .+'),
        '- **Configured Communication Language:** $configuredLang',
      );
    }
  }

  // Default for core architecture, state management, pre-push quality gate:
  // Use updated upstream section to guarantee quality gates, rules and standards are up to date
  return upstreamSec;
}

void syncOtherAiFiles(Directory projectDir, String packageName, bool dryRun) {
  // Sync CLAUDE.md if present
  final claudeFile = File('${projectDir.path}/CLAUDE.md');
  if (claudeFile.existsSync()) {
    print('🤖 Found CLAUDE.md — ensuring Clean Architecture and Pre-Push references are intact.');
    final content = claudeFile.readAsStringSync();
    if (!content.contains('Pre-Push Quality Gate')) {
      final updated = content + '\n\n## Mandatory Pre-Push Quality Gate\nAlways verify `dart run import_sorter:main`, `dart format --output=none --set-exit-if-changed .`, `dart analyze --fatal-infos`, and `flutter test` before pushing.\n';
      if (!dryRun) claudeFile.writeAsStringSync(updated);
      print('   ✅ Updated CLAUDE.md with Pre-Push Quality Gate');
    }
  }

  // Sync .cursorrules if present
  final cursorFile = File('${projectDir.path}/.cursorrules');
  if (cursorFile.existsSync()) {
    print('🤖 Found .cursorrules — verifying standards.');
    final content = cursorFile.readAsStringSync();
    if (!content.contains('Pre-Push Quality Gate')) {
      final updated = content + '\n\n# Pre-Push Quality Gate\nBefore pushing: dart run import_sorter:main, dart format, dart analyze --fatal-infos, flutter test.\n';
      if (!dryRun) cursorFile.writeAsStringSync(updated);
      print('   ✅ Updated .cursorrules with Pre-Push Quality Gate');
    }
  }
}
