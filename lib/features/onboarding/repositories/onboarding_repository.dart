import '../../../core/errors/app_exception.dart';
import '../../../core/storage/boxes.dart';
import '../../../core/storage/hive_service.dart';

class OnboardingRepository {
  OnboardingRepository(this._storage);

  static const String _seenKey = 'onboarding_seen';

  final HiveService _storage;

  Future<bool> hasSeenOnboarding() async {
    try {
      return await _storage.read<bool>(Boxes.appState, _seenKey) ?? false;
    } on StorageException {
      return false;
    }
  }

  Future<void> markOnboardingSeen() async {
    try {
      await _storage.write(Boxes.appState, _seenKey, true);
    } on StorageException {
      // A failed write only means onboarding shows again on the next launch.
    }
  }
}