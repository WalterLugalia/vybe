import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_footer.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

    @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        ref.read(authProvider.notifier).clearError();
      }
    });
  }
   @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    await ref.read(authProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _fullNameController.text.trim(),
          username: _usernameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final error = authState.error;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 64),
                    Text(
                      'Create your account',
                      style: AppTextStyles.headline.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Join a community built around videos, '
                      'discovery and participation.',
                      style: AppTextStyles.tagline.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: AutofillGroup(
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _fullNameController,
                              hintText: 'Full name',
                              validator: Validators.fullName,
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.name],
                            ),
                            const SizedBox(height: AppSpacing.fieldGap),
                            AppTextField(
                              controller: _usernameController,
                              hintText: 'Username',
                              validator: Validators.username,
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.newUsername],
                            ),
                            const SizedBox(height: AppSpacing.fieldGap),
                            AppTextField(
                              controller: _emailController,
                              hintText: 'Email address',
                              validator: Validators.email,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                            ),
                            const SizedBox(height: AppSpacing.fieldGap),
                            AppTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              validator: Validators.newPassword,
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.newPassword],
                            ),
                            const SizedBox(height: AppSpacing.fieldGap),
                            AppTextField(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm password',
                              validator: (value) => Validators.confirmPassword(
                                value,
                                _passwordController.text,
                              ),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              autofillHints: const [AutofillHints.newPassword],
                              onSubmitted: (_) => _submit(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  if (error != null) ...[
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        error.message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.coral,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  AppButton(
                    label: 'Create account',
                    isLoading: authState.isBusy,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const AuthFooter(),
          ],
        ),
      ),
    );
  }
}