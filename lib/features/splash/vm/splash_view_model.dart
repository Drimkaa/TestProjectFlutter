import 'package:flutter/foundation.dart';
import '../../onboarding/domain/use_cases/check_onboarding_completion.dart';

class SplashViewModel extends ChangeNotifier {
  final CheckOnboardingCompletion _checkOnboardingCompletion;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _shouldShowOnboarding = false;
  bool get shouldShowOnboarding => _shouldShowOnboarding;

  SplashViewModel(this._checkOnboardingCompletion);

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasCompleted = await _checkOnboardingCompletion();
    _shouldShowOnboarding = !hasCompleted;
    _isLoading = false;

    notifyListeners();
  }
}
