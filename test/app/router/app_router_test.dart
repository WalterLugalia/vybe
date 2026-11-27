import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/app/router/app_router.dart';
import 'package:vybe/app/router/route_paths.dart';

void main() {
  testWidgets('router starts on the splash route', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = container.read(appRouterProvider);

    expect(
      router.routeInformationProvider.value.uri.path,
      RoutePaths.splash,
    );
  });
}