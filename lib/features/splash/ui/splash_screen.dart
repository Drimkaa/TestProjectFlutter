import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../home/ui/home_screen.dart';
import '../../onboarding/ui/onboarding_screen.dart';
import '../vm/splash_view_model.dart';


/// View describes how to present data to the user
/// Contains only simple UI logic and animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    final viewModel = context.read<SplashViewModel>();
    await viewModel.initialize();

    if (!mounted) return;

    final destination = viewModel.shouldShowOnboarding
        ? const OnboardingScreen()
        : const HomeScreen();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const JumpingIcon(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class JumpingIcon extends StatefulWidget {
  const JumpingIcon({super.key});

  @override
  State<JumpingIcon> createState() => _JumpingIconState();
}

class _JumpingIconState extends State<JumpingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);

    _jumpAnimation = Tween<double>(begin: 0, end: -40).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _jumpAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _jumpAnimation.value),
          child: child,
        );
      },
      child: Image.asset(
        'assets/iteco.png',
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}