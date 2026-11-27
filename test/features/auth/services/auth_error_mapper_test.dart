import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/features/auth/services/auth_error_mapper.dart';

Matcher _authFailure(AuthFailure failure) {
  return isA<AuthException>().having((e) => e.failure, 'failure', failure);
}

void main() {
  test('invalid_credentials code maps to invalidCredentials', () {
    final error = supabase.AuthException(
      'Invalid login credentials',
      code: 'invalid_credentials',
    );

    expect(mapAuthError(error), _authFailure(AuthFailure.invalidCredentials));
  });

  test('sign-in message without a code still maps to invalidCredentials', () {
    final error = supabase.AuthException('Invalid login credentials');

    expect(mapAuthError(error), _authFailure(AuthFailure.invalidCredentials));
  });

  test('user_already_exists maps to emailAlreadyRegistered', () {
    final error = supabase.AuthException(
      'User already registered',
      code: 'user_already_exists',
    );

    expect(
      mapAuthError(error),
      _authFailure(AuthFailure.emailAlreadyRegistered),
    );
  });

  test('weak password exception maps to weakPassword', () {
    final error = supabase.AuthWeakPasswordException(
      message: 'Password is too short',
      statusCode: '422',
      reasons: ['length'],
    );

    expect(mapAuthError(error), _authFailure(AuthFailure.weakPassword));
  });

  test('a network failure maps to NetworkException', () {
    final error = supabase.AuthRetryableFetchException(message: 'no route');

    expect(mapAuthError(error), isA<NetworkException>());
  });

  test('an unrecognized auth code maps to AuthFailure.unknown', () {
    final error = supabase.AuthException('Something new', code: 'brand_new');

    expect(mapAuthError(error), _authFailure(AuthFailure.unknown));
  });

  test('an error that is not an auth error maps to UnknownException', () {
    expect(mapAuthError(StateError('boom')), isA<UnknownException>());
  });

  test('an error that is already an AppException is returned unchanged', () {
    const original = StorageException();

    expect(mapAuthError(original), same(original));
  });
}