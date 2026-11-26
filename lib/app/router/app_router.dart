import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/auth/screens/sign_up_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: RoutePaths.welcome,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.signIn,
        name: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePaths.signUp,
        name: RouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});