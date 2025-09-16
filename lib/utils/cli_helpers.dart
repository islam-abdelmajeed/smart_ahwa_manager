import 'dart:io';

String? argValue(List<String> parts, int idx) => (parts.length > idx) ? parts[idx] : null;

String? namedArg(List<String> parts, String key) {
  final kv = parts.skip(1).firstWhere(
        (p) => p.startsWith('$key='),
        orElse: () => '',
      );
  if (kv.isEmpty) return null;
  return kv.substring(key.length + 1).replaceAll(RegExp(r'^"|"$'), '');
}

String prompt(String label) {
  stdout.write('$label: ');
  return stdin.readLineSync()!.trim();
}
