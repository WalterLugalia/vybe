import 'route_names.dart';

String? startRouteName({
  required bool isAuthenticated,
  required bool hasSeenOnboarding,
}) {
  if (isAuthenticated) {
    return null;
  }
  return hasSeenOnboarding ? RouteNames.welcome : RouteNames.onboarding;
}