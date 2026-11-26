import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../shared/widgets/intro_layout.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroLayout(
      title: 'A world beyond the scroll',
      body:
          'Watch, discover and take part in experiences that bring people '
          'together.',
      primaryLabel: 'Continue',
      onPrimary: () => context.goNamed(RouteNames.welcome),
      secondaryLabel: 'Skip',
      onSecondary: () => context.goNamed(RouteNames.welcome),
    );
  }
}