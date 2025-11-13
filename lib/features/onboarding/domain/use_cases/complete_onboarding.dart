import '../../data/repositories/onboarding_repository.dart';

class CompleteOnboarding {
  final OnboardingRepository _repository;

  CompleteOnboarding(this._repository);

  Future<void> call() async {
    await _repository.completeOnboarding();
  }
}
