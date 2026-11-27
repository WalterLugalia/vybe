import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_text_button.dart';
import 'hero_card.dart';

class IntroLayout extends StatelessWidget {
  const IntroLayout({
    super.key,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
  });

  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;

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
                        title,
                        style: AppTextStyles.display.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        body,
                        style: AppTextStyles.tagline.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              AppButton(label: primaryLabel, onPressed: onPrimary),
              const SizedBox(height: 6),
              AppTextButton(label: secondaryLabel, onPressed: onSecondary),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}