import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/app/app.dart';
import 'package:vybe/features/auth/providers/auth_provider.dart';
import 'package:vybe/features/auth/providers/auth_state.dart';
import 'package:vybe/features/onboarding/providers/onboarding_provider.dart';
import 'package:vybe/features/onboarding/repositories/onboarding_repository.dart';

class _SignedOutNotifier extends AuthNotifier {
  @override
  AuthState build() => const AuthState();
}

class _NeverSeenOnboarding implements OnboardingRepository {
  @override
  Future<bool> hasSeenOnboarding() async => false;

  @override
  Future<void> markOnboardingSeen() async {}
}

void main() {
  testWidgets('splash leads a new signed-out user to onboarding',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(_SignedOutNotifier.new),
          onboardingRepositoryProvider.overrideWithValue(
            _NeverSeenOnboarding(),
          ),
        ],
        child: const VybeApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('VYBE'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('A world beyond the scroll'), findsOneWidget);
  });
}