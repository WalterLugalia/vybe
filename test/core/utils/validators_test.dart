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

  group('Validators.fullName', () {
    test('rejects null, empty and blank input', () {
      expect(Validators.fullName(null), isNotNull);
      expect(Validators.fullName(''), isNotNull);
      expect(Validators.fullName('   '), isNotNull);
    });

    test('accepts a name', () {
      expect(Validators.fullName('Maya N.'), isNull);
    });
  });

  group('Validators.username', () {
    test('rejects null and empty input', () {
      expect(Validators.username(null), isNotNull);
      expect(Validators.username(''), isNotNull);
    });

    test('rejects the wrong length or characters', () {
      expect(Validators.username('ab'), isNotNull);
      expect(Validators.username('a' * 21), isNotNull);
      expect(Validators.username('maya!'), isNotNull);
      expect(Validators.username('ma ya'), isNotNull);
    });

    test('accepts letters, numbers and underscores at the length limits', () {
      expect(Validators.username('maya_n'), isNull);
      expect(Validators.username('Maya123'), isNull);
      expect(Validators.username('abc'), isNull);
      expect(Validators.username('a' * 20), isNull);
    });
  });

  group('Validators.newPassword', () {
    test('rejects null and empty input', () {
      expect(Validators.newPassword(null), isNotNull);
      expect(Validators.newPassword(''), isNotNull);
    });

    test('rejects a password shorter than the minimum', () {
      expect(Validators.newPassword('1234567'), isNotNull);
    });

    test('accepts a password of the minimum length', () {
      expect(Validators.newPassword('12345678'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('rejects null and empty input', () {
      expect(Validators.confirmPassword(null, 'password1'), isNotNull);
      expect(Validators.confirmPassword('', 'password1'), isNotNull);
    });

    test('rejects a different password', () {
      expect(Validators.confirmPassword('password2', 'password1'), isNotNull);
    });

    test('accepts the same password', () {
      expect(Validators.confirmPassword('password1', 'password1'), isNull);
    });
  });
}