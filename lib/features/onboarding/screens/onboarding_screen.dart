import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../shared/widgets/intro_layout.dart';
import '../providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(BuildContext context, WidgetRef ref) async {
    await ref.read(onboardingRepositoryProvider).markOnboardingSeen();
    if (context.mounted) {
      context.goNamed(RouteNames.welcome);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntroLayout(
      title: 'A world beyond the scroll',
      body:
          'Watch, discover and take part in experiences that bring people '
          'together.',
      primaryLabel: 'Continue',
      onPrimary: () => _finish(context, ref),
      secondaryLabel: 'Skip',
      onSecondary: () => _finish(context, ref),
    );
  }
}