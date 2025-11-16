import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_project/features/onboarding/ui/widgets/matrix_text.dart';

import '../../home/ui/home_screen.dart';
import '../vm/onboarding_view_model.dart';
import 'widgets/onboarding_page.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Future<void> _routeToHomeScreen() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> _finishOnboarding() async {
    final viewModel = context.read<OnboardingViewModel>();
    await viewModel.finishOnboarding();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<OnboardingViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: viewModel.setPage,
                    itemCount: viewModel.totalPages,
                    itemBuilder: (context, index) {
                      return OnboardingPageWidget(
                        content: viewModel.pages[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: viewModel.totalPages,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 12,
                      radius: 16,
                      dotColor: Theme.of(context).colorScheme.secondary,
                      activeDotColor: Theme.of(context).primaryColor,

                    ),
                    onDotClicked: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: viewModel.isLoading
                        ? null
                        : () {
                      if (viewModel.isLastPage) {
                        _routeToHomeScreen();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: viewModel.isLoading
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : AnimatedMatrixText(
                      texts: ['Продолжить', 'Начать'],
                      currentIndex: viewModel.isLastPage ? 1 : 0,
                      style:  TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w900,
                      ),
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () {
                      if (viewModel.isLastPage) {
                        _finishOnboarding();
                      } else {
                        _pageController.animateToPage(
                          viewModel.totalPages - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      viewModel.isLastPage ? 'Больше не показывать' : 'Пропустить',
                      style:  TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
