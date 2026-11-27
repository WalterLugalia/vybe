import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/app/router/route_names.dart';
import 'package:vybe/app/router/startup_route.dart';

void main() {
  test('a signed-in user stays where they are', () {
    expect(
      startRouteName(isAuthenticated: true, hasSeenOnboarding: false),
      isNull,
    );
    expect(
      startRouteName(isAuthenticated: true, hasSeenOnboarding: true),
      isNull,
    );
  });

  test('a new signed-out user goes to onboarding', () {
    expect(
      startRouteName(isAuthenticated: false, hasSeenOnboarding: false),
      RouteNames.onboarding,
    );
  });

  test('a returning signed-out user goes to welcome', () {
    expect(
      startRouteName(isAuthenticated: false, hasSeenOnboarding: true),
      RouteNames.welcome,
    );
  });
}