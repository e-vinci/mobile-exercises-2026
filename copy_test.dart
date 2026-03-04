import 'dart:io';

/// Script to copy test files from the centralized test structure
/// to tutorial folders in the whotesthetests directory
void main() async {
  final workspaceRoot = Directory.current;
  final centralTestDir = Directory('${workspaceRoot.path}/test');

  print('Checking for tutorial folders in root...');

  if (!centralTestDir.existsSync()) {
    print('❌ Central test directory not found!');
    return;
  }

  // Get all tutorial directories from whotesthetests
  final tutorialDirs = workspaceRoot
      .listSync()
      .whereType<Directory>()
      .where((dir) => dir.path.contains('tuto'))
      .toList();

  if (tutorialDirs.isEmpty) {
    print('❌ No tutorial directories found in root');
    return;
  }

  print('Found ${tutorialDirs.length} tutorial directories:');
  for (final tutorialDir in tutorialDirs) {
    final tutorialName = tutorialDir.path.split(Platform.pathSeparator).last;
    print('  - $tutorialName');
  }

  // Process each tutorial directory
  for (final tutorialDir in tutorialDirs) {
    final tutorialName = tutorialDir.path.split(Platform.pathSeparator).last;
    final sourceTestDir = Directory('${centralTestDir.path}/$tutorialName');
    final targetTestDir = Directory('${tutorialDir.path}/test');

    print('\n📁 Processing $tutorialName...');

    // Check if source test directory exists in central test structure
    if (!sourceTestDir.existsSync()) {
      print(
        '  ⚠️  No test files found for $tutorialName in central test directory',
      );
      continue;
    }

    // Create target test directory if it doesn't exist
    if (!targetTestDir.existsSync()) {
      print('  📂 Creating test directory in $tutorialName');
      targetTestDir.createSync(recursive: true);
    }

    // Copy all files from source to target
    try {
      await copyDirectory(sourceTestDir, targetTestDir);
      print('  ✅ Successfully copied test files to $tutorialName');
    } catch (e) {
      print('  ❌ Error copying test files to $tutorialName: $e');
    }
  }

  print('\n🎉 Test file copying completed!');
}

/// Recursively copies all files and directories from source to destination
Future<void> copyDirectory(Directory source, Directory destination) async {
  await for (final entity in source.list(recursive: false)) {
    if (entity is File) {
      final targetFile = File(
        '${destination.path}/${entity.path.split(Platform.pathSeparator).last}',
      );
      await entity.copy(targetFile.path);
    } else if (entity is Directory) {
      final targetDir = Directory(
        '${destination.path}/${entity.path.split(Platform.pathSeparator).last}',
      );
      if (!targetDir.existsSync()) {
        targetDir.createSync(recursive: true);
      }
      await copyDirectory(entity, targetDir);
    }
  }
}
