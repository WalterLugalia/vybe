import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/app/app.dart';

void main() {
  testWidgets('app starts on the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: VybeApp()));
    await tester.pumpAndSettle();

    expect(find.text('VYBE'), findsOneWidget);
  });
}