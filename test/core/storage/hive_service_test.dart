import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/core/storage/hive_service.dart';

void main() {
  late Directory directory;
  final service = HiveService();

  setUp(() {
    directory = Directory.systemTemp.createTempSync('vybe_hive_test');
    Hive.init(directory.path);
  });

  tearDown(() async {
    await Hive.close();
    directory.deleteSync(recursive: true);
  });

  test('a written value can be read back', () async {
    await service.write('settings', 'language', 'en');

    expect(await service.read<String>('settings', 'language'), 'en');
  });

  test('reading a missing key returns null', () async {
    expect(await service.read<String>('settings', 'missing'), isNull);
  });

  test('a deleted value is gone', () async {
    await service.write('settings', 'language', 'en');
    await service.delete('settings', 'language');

    expect(await service.read<String>('settings', 'language'), isNull);
  });

  test('a value survives closing and reopening storage', () async {
    await service.write('settings', 'language', 'en');

    await Hive.close();
    Hive.init(directory.path);

    expect(await service.read<String>('settings', 'language'), 'en');
  });

  test('reading a value of the wrong type throws a StorageException', () async {
    await service.write('settings', 'language', 'en');

    await expectLater(
      service.read<int>('settings', 'language'),
      throwsA(isA<StorageException>()),
    );
  });
}