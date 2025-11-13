import '../../data/repositories/onboarding_repository.dart';

class CheckOnboardingCompletion {
  final OnboardingRepository _repository;

  CheckOnboardingCompletion(this._repository);

  Future<bool> call() async {
    return await _repository.hasCompletedOnboarding();
  }
}
