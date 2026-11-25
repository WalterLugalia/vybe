import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('rejects null and empty input', () {
      expect(Validators.email(null), isNotNull);
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('   '), isNotNull);
    });

    test('rejects text that is not shaped like an email', () {
      expect(Validators.email('maya'), isNotNull);
      expect(Validators.email('maya@'), isNotNull);
      expect(Validators.email('maya@example'), isNotNull);
      expect(Validators.email('maya @example.com'), isNotNull);
    });

    test('accepts a normal address, even with surrounding spaces', () {
      expect(Validators.email('maya@example.com'), isNull);
      expect(Validators.email('  maya@example.com  '), isNull);
    });
  });

  group('Validators.requiredPassword', () {
    test('rejects null and empty input', () {
      expect(Validators.requiredPassword(null), isNotNull);
      expect(Validators.requiredPassword(''), isNotNull);
    });

    test('accepts any non-empty password, including spaces', () {
      expect(Validators.requiredPassword('x'), isNull);
      expect(Validators.requiredPassword(' '), isNull);
    });
  });
}