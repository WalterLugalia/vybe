import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../core/errors/app_exception.dart';

AppException mapAuthError(Object error) {
  if (error is AppException) {
    return error;
  }
  if (error is supabase.AuthRetryableFetchException) {
    return NetworkException(cause: error);
  }
  if (error is supabase.AuthWeakPasswordException) {
    return _failure(AuthFailure.weakPassword, error);
  }
  if (error is supabase.AuthException) {
    return _failure(_failureFor(error), error);
  }
  return UnknownException(cause: error);
}

AuthFailure _failureFor(supabase.AuthException error) {
  final code = error.code;
  final message = error.message.toLowerCase();

  if (code == 'invalid_credentials' ||
      message.contains('invalid login credentials')) {
    return AuthFailure.invalidCredentials;
  }
  if (code == 'user_already_exists' ||
      code == 'email_exists' ||
      message.contains('already registered')) {
    return AuthFailure.emailAlreadyRegistered;
  }
  if (code == 'weak_password') {
    return AuthFailure.weakPassword;
  }
  if (code == 'email_not_confirmed' ||
      message.contains('email not confirmed')) {
    return AuthFailure.emailNotConfirmed;
  }
  if (code == 'over_request_rate_limit' ||
      code == 'over_email_send_rate_limit' ||
      error.statusCode == '429') {
    return AuthFailure.tooManyRequests;
  }
  if (code == 'signup_disabled') {
    return AuthFailure.signUpDisabled;
  }
  return AuthFailure.unknown;
}

AuthException _failure(AuthFailure failure, Object cause) {
  return AuthException(
    failure: failure,
    message: _messageFor(failure),
    cause: cause,
  );
}

String _messageFor(AuthFailure failure) {
  return switch (failure) {
    AuthFailure.invalidCredentials => 'Incorrect email or password.',
    AuthFailure.emailAlreadyRegistered =>
      'An account with this email already exists.',
    AuthFailure.weakPassword =>
      'Choose a stronger password of at least 8 characters.',
    AuthFailure.emailNotConfirmed =>
      'Please verify your email before signing in.',
    AuthFailure.tooManyRequests =>
      'Too many attempts. Please wait a moment and try again.',
    AuthFailure.signUpDisabled => 'Sign up is not available right now.',
    AuthFailure.unknown =>
      'Could not complete authentication. Please try again.',
  };
}