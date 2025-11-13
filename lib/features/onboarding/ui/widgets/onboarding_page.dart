import 'package:flutter/material.dart';
import '../../domain/models/onboarding_page_content.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageContent content;

  const OnboardingPageWidget({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Text(
            content.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          if (content.imagePath != null)
            Image.asset(content.imagePath!, height: 300)

        ],
      ),
    );
  }
}
