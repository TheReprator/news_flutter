import 'dart:io';

Future<String> readResponseFromFile(String filePath) async =>
    await File(filePath).readAsString();
