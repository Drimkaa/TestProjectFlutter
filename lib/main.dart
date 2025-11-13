import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/features/home/data/repositories/product_repository.dart';
import 'package:test_project/features/home/data/services/product_service.dart';
import 'package:test_project/features/home/domain/use_cases/get_products.dart';

import 'features/home/vm/home_view_model.dart';
import 'features/onboarding/vm/onboarding_view_model.dart';
import 'features/splash/ui/splash_screen.dart';
import 'features/onboarding/data/services/onboarding_storage_service.dart';
import 'features/onboarding/data/repositories/onboarding_repository.dart';
import 'features/onboarding/domain/use_cases/check_onboarding_completion.dart';
import 'features/onboarding/domain/use_cases/complete_onboarding.dart';
import 'features/splash/vm/splash_view_model.dart';


void main() {
  // Initialize Data Layer
  final onboardingStorageService = OnboardingStorageService();
  final onboardingRepository = OnboardingRepository(onboardingStorageService);

  // Initialize Domain Layer (Use Cases)
  final checkOnboardingCompletion = CheckOnboardingCompletion(onboardingRepository);
  final completeOnboarding = CompleteOnboarding(onboardingRepository);

  final dio = Dio();
  final productService = ProductService(dio);
  final productRepository = ProductRepository(productService);
  final getProducts = GetProducts(productRepository);
  runApp(
    MultiProvider(
      providers: [
        // Splash feature
        ChangeNotifierProvider(
          create: (_) => SplashViewModel(checkOnboardingCompletion),
        ),

        // Onboarding feature
        ChangeNotifierProvider(
          create: (_) => OnboardingViewModel(completeOnboarding),
        ),

        // Home feature
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(getProducts),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
      primarySwatch: Colors.amber,               // Главное цветовое семейство (app bar, кнопки и др.)
      scaffoldBackgroundColor: Colors.white,   // Фон всего экрана
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.amber,
      ).copyWith(
        secondary: Colors.black87,        // Акцентный цвет (например, для FloatingActionButton)
      ).copyWith(
        onTertiary: Colors.black38
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.amber,              // Цвет кнопок
        textTheme: ButtonTextTheme.primary,
      ),
        cardTheme: const CardThemeData(
          color: Colors.black12
        )
    ),
      home: const SplashScreen(),
    );
  }
}
