import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'route_paths.dart';
import 'temporary_home_screen.dart';


final appRouterProvider = Provider<GoRouter>((ref){
  final router = GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const TemporaryHomeScreen(),
      ),
    ]
  );
  ref.onDispose(router.dispose);
  return router;
});