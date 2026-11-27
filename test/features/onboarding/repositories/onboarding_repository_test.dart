import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/core/storage/hive_service.dart';
import 'package:vybe/features/onboarding/repositories/onboarding_repository.dart';

class _FakeStorage implements HiveService {
  final Map<String, Object> values = {};
  bool failing = false;

  @override
  Future<T?> read<T>(String boxName, String key) async {
    if (failing) {
      throw const StorageException();
    }
    return values['$boxName/$key'] as T?;
  }

  @override
  Future<void> write(String boxName, String key, Object value) async {
    if (failing) {
      throw const StorageException();
    }
    values['$boxName/$key'] = value;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    values.remove('$boxName/$key');
  }
}

void main() {
  test('onboarding counts as not seen when nothing was saved', () async {
    final repository = OnboardingRepository(_FakeStorage());

    expect(await repository.hasSeenOnboarding(), isFalse);
  });

  test('onboarding counts as seen after it was marked', () async {
    final repository = OnboardingRepository(_FakeStorage());

    await repository.markOnboardingSeen();

    expect(await repository.hasSeenOnboarding(), isTrue);
  });

  test('a storage failure while reading counts as not seen', () async {
    final storage = _FakeStorage()..failing = true;
    final repository = OnboardingRepository(storage);

    expect(await repository.hasSeenOnboarding(), isFalse);
  });

  test('a storage failure while saving does not throw', () async {
    final storage = _FakeStorage()..failing = true;
    final repository = OnboardingRepository(storage);

    await repository.markOnboardingSeen();
  });
}