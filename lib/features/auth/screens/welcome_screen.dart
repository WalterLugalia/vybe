import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_button.dart';
import '../../../shared/widgets/hero_card.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 71),
                      const HeroCard(),
                      const SizedBox(height: 30),
                      Text(
                        'Your next vibe starts here',
                        style: AppTextStyles.display.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Watch something. Discover something. '
                        'Be part of something.',
                        style: AppTextStyles.tagline.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              AppButton(
                label: 'Create account',
                onPressed: () => context.pushNamed(RouteNames.signUp),
              ),
              const SizedBox(height: 6),
              AppTextButton(
                label: 'Sign in',
                onPressed: () => context.pushNamed(RouteNames.signIn),
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}