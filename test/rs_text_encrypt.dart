import 'dart:io';
import 'package:encrypt/encrypt.dart';

void main() {
  // Original key from user (invalid length 26)
  const rawKey = '32554657765867879879879876';
  // Pad to 32 bytes
  final validKeyStr = rawKey.padRight(32, '0');

  final key = Key.fromUtf8(validKeyStr);
  final iv = IV.fromBase64('gScioPT85qqx5d/ExwMvbw==');
  final ivBase64 = iv.base64;
  final keyStr = validKeyStr;
  final encrypter = Encrypter(AES(key));

  String encrypt(String input) {
    return encrypter.encrypt(input, iv: iv).base64;
  }

  final file = File(
    '/Users/wangchao/Documents/work/rose_say/lib/rsCommon/rs_values/rs_textData.dart',
  );
  final lines = file.readAsLinesSync();

  // Ensure the target file imports encrypt if it doesn't already.
  const encryptImport = "import 'package:encrypt/encrypt.dart';";
  if (!lines.contains(encryptImport)) {
    final firstImport = lines.indexWhere((l) => l.startsWith('import '));
    if (firstImport == -1) {
      lines.insert(0, encryptImport);
    } else {
      var insertPos = firstImport;
      while (insertPos + 1 < lines.length &&
          lines[insertPos + 1].startsWith('import ')) {
        insertPos++;
      }
      lines.insert(insertPos + 1, encryptImport);
    }
  }

  final newLines = <String>[];

  // We'll insert helper fields and method if missing.
  var insertedDecryptHelpers = false;

  // Regexes
  final regexSingle = RegExp(r"'([^'\\]*(?:\\.[^'\\]*)*)'");
  final regexDouble = RegExp(r'"([^"\\]*(?:\\.[^"\\]*)*)"');

  for (var line in lines) {
    // Keep the encrypt import line untouched.
    if (line.trim() == encryptImport) {
      newLines.add(line);
      continue;
    }

    // If the file already contains the helper definitions, skip insertion.
    if (!insertedDecryptHelpers &&
        (line.contains('static String _decrypt(') ||
            line.contains('static final _iv =') ||
            line.contains('static final _key ='))) {
      insertedDecryptHelpers = true;
    }

    // If we just saw the class declaration, insert helpers right after it.
    if (!insertedDecryptHelpers &&
        line.trimLeft().startsWith('class ') &&
        line.contains('{')) {
      newLines.add(line);
      newLines.add('');
      newLines.add('  // Encryption Keys');
      newLines.add("  static final _key = Key.fromUtf8('$keyStr');");
      newLines.add("  static final _iv = IV.fromBase64('$ivBase64');");
      newLines.add('');
      newLines.add('  static String _decrypt(String base64) {');
      newLines.add('    final encrypter = Encrypter(AES(_key));');
      newLines.add('    return encrypter.decrypt64(base64, iv: _iv);');
      newLines.add('  }');
      newLines.add('');
      insertedDecryptHelpers = true;
      continue;
    }

    // Update the key definition
    if (line.contains('static final _key = Key.fromUtf8')) {
      newLines.add("  static final _key = Key.fromUtf8('$validKeyStr');");
      continue;
    }

    // Skip IV line and others, keep them as is
    if (line.contains('Key.fromUtf8') ||
        line.contains('IV.fromBase64') ||
        line.contains('package:encrypt')) {
      newLines.add(line);
      continue;
    }

    // Skip the _decrypt method definition itself
    if (line.contains('_decrypt(')) {
      newLines.add(line);
      continue;
    }

    String newLine = line;

    // Helper to process regex
    newLine = processRegex(regexSingle, newLine, encrypt);
    newLine = processRegex(regexDouble, newLine, encrypt);

    newLines.add(newLine);
  }

  // Write back
  final outputFile = File(
    '/Users/wangchao/Documents/work/rose_say/lib/rsCommon/rs_values/rs_textData.dart',
  );
  outputFile.writeAsStringSync(newLines.join('\n'));
  print('Done. Check ${outputFile.path}');
}

String processRegex(
  RegExp regex,
  String line,
  String Function(String) encryptFunc,
) {
  String newLine = line;
  final matches = regex.allMatches(line);
  final matchesList = matches.toList();

  for (var i = matchesList.length - 1; i >= 0; i--) {
    final match = matchesList[i];
    final content = match.group(1);

    if (content == null) continue;

    if (content.contains(r'$')) {
      continue;
    }

    // We only encrypt non-empty strings usually, but empty strings are fine to encrypt too.
    // If quote is double, unescape \"
    // If quote is single, unescape \'
    String valueToEncrypt = content;

    // Check which quote type by checking the full match text
    final fullMatch = line.substring(match.start, match.end);
    final isDouble = fullMatch.startsWith('"');

    if (isDouble) {
      if (valueToEncrypt.contains(r'\"')) {
        valueToEncrypt = valueToEncrypt.replaceAll(r'\"', '"');
      }
    } else {
      if (valueToEncrypt.contains(r"\'")) {
        valueToEncrypt = valueToEncrypt.replaceAll(r"\'", "'");
      }
    }

    if (valueToEncrypt.contains(r"\\")) {
      valueToEncrypt = valueToEncrypt.replaceAll(r"\\", r"\");
    }
    valueToEncrypt = valueToEncrypt.replaceAll(r'\n', '\n');

    try {
      final encrypted = encryptFunc(valueToEncrypt);

      final replacement = "_decrypt('$encrypted')";
      newLine = newLine.replaceRange(match.start, match.end, replacement);

      if (newLine.contains('static const')) {
        newLine = newLine.replaceFirst('static const', 'static final');
      }
    } catch (e) {
      print('Error encrypting match: $fullMatch. Error: $e');
    }
  }
  return newLine;
}
