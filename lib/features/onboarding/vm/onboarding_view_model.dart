import 'package:flutter/foundation.dart';
import '../domain/models/onboarding_page_content.dart';
import '../domain/use_cases/complete_onboarding.dart';

class OnboardingViewModel extends ChangeNotifier {
  final CompleteOnboarding _completeOnboarding;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<OnboardingPageContent> pages = [
    const OnboardingPageContent(
      title: 'Привет!',
      description: 'Добро пожаловать в тестовое приложение',
    ),
    const OnboardingPageContent(
      title: 'Сделал это',
      imagePath: "assets/1.png",
      description: 'Посмотрите на кнопку Продолжить \n при переходе на следующую странциу',
    ),
    const OnboardingPageContent(
      title: 'А дальше?',
      description: 'Дальше лучше, FakeStoreAPI',
      imagePath: "assets/2.png",
    ),
  ];

  OnboardingViewModel(this._completeOnboarding);

  int get totalPages => pages.length;
  bool get isLastPage => _currentPage == totalPages - 1;
  bool get isFirstPage => _currentPage == 0;
  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  Future<void> finishOnboarding() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _completeOnboarding();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
