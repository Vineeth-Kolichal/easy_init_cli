import 'dart:io';

import 'package:easy_init_cli/core/structure/tdd_clean_structure/tdd_clean_structure.dart';
import 'package:easy_init_cli/core/structure/models/structure.dart';

void main() {
  print("Verifying TddCleanStructure changes...");

  final structure = TddCleanStructure();

  // 1. Verify CleanDirName.aiDocs
  print("1. Verifying directory structure...");
  final aiDocsDir = structure.directoryStructure[CleanDirName.aiDocs];
  if (aiDocsDir != null && aiDocsDir.path.endsWith("ai_docs")) {
    print("✅ ai_docs directory present in structure.");
  } else {
    print("❌ ai_docs directory MISSING or incorrect path: ${aiDocsDir?.path}");
    exit(1);
  }

  // 2. Verify coreFiles contains the new files
  print("2. Verifying coreFiles...");
  final coreFiles = structure.coreFiles;

  bool hasStylingGuide = false;
  bool hasApiFlowGuide = false;
  bool hasReadme = false;

  for (final file in coreFiles) {
    if (file.filePath.endsWith("styling_guide.md")) {
      hasStylingGuide = true;
      if (file.content.contains("# Styling Guide for AI Coding Assistants")) {
        print("✅ styling_guide.md found with correct content header.");
      } else {
        print("❌ styling_guide.md found but content might be wrong.");
      }
    }
    if (file.filePath.endsWith("api_flow_guide.md")) {
      hasApiFlowGuide = true;
      if (file.content.contains("# API Call Flow & Clean Architecture Guide")) {
        print("✅ api_flow_guide.md found with correct content header.");
      } else {
        print("❌ api_flow_guide.md found but content might be wrong.");
      }
    }
    if (file.filePath.endsWith("README.md")) {
      hasReadme = true;
      if (file.content.contains("## 🤖 AI Vibe Coding")) {
        print("✅ README.md found with AI Vibe Coding section.");
      } else {
        print("❌ README.md found but content might be wrong.");
      }
    }
  }

  if (hasStylingGuide && hasApiFlowGuide && hasReadme) {
    print("✅ All new files are present in coreFiles.");
  } else {
    print("❌ Some files are missing:");
    if (!hasStylingGuide) print("  - styling_guide.md");
    if (!hasApiFlowGuide) print("  - api_flow_guide.md");
    if (!hasReadme) print("  - README.md");
    exit(1);
  }

  print("✅ Verification SUCCESS!");
}
