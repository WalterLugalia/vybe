abstract final class Validators {
  static const int minPasswordLength = 8;

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _usernamePattern = RegExp(r'^[A-Za-z0-9_]{3,20}$');

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Enter your email address.';
    }
    if (!_emailPattern.hasMatch(text)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? requiredPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password.';
    }
    return null;
  }

  static String? fullName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Enter your full name.';
    }
    return null;
  }

  static String? username(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Choose a username.';
    }
    if (!_usernamePattern.hasMatch(text)) {
      return 'Use 3 to 20 letters, numbers or underscores.';
    }
    return null;
  }

  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Choose a password.';
    }
    if (value.length < minPasswordLength) {
      return 'Use at least $minPasswordLength characters.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }
}