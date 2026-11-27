import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../shared/widgets/intro_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroLayout(
      title: 'Your next vibe starts here',
      body: 'Watch something. Discover something. Be part of something.',
      primaryLabel: 'Create account',
      onPrimary: () => context.pushNamed(RouteNames.signUp),
      secondaryLabel: 'Sign in',
      onSecondary: () => context.pushNamed(RouteNames.signIn),
    );
  }
}