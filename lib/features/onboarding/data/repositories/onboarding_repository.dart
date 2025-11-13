import '../services/onboarding_storage_service.dart';


class OnboardingRepository {
  final OnboardingStorageService _storageService;

  OnboardingRepository(this._storageService);

  /// проверка на пройденность
  Future<bool> hasCompletedOnboarding() async {
    try {
      return await _storageService.isOnboardingCompleted();
    } catch (e) {
      return false;
    }
  }

  /// пометить onboarding пройденным
  Future<void> completeOnboarding() async {
    try {
      await _storageService.setOnboardingCompleted(true);
    } catch (e) {
      rethrow;
    }
  }
}
