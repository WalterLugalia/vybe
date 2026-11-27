import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../models/app_user.dart';
import 'auth_error_mapper.dart';

class AuthService {
  supabase.GoTrueClient get _auth => supabase.Supabase.instance.client.auth;

  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  Stream<AppUser?> get userChanges {
    return _auth.onAuthStateChange.map((state) {
      return _toAppUser(state.session?.user);
    });
  }

  Future<AppUser> signUp({
    required String email,
    required String password,
    required String fullName,
    required String username,
  }) {
    return _run(() async {
      final response = await _auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName, 'username': username},
      );
      return _requireUser(response.user);
    });
  }

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) {
    return _run(() async {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );
      return _requireUser(response.user);
    });
  }

  Future<void> signOut() {
    return _run(() => _auth.signOut());
  }

  AppUser? _toAppUser(supabase.User? user) {
    if (user == null) {
      return null;
    }
    return AppUser(
      id: user.id,
      email: user.email ?? '',
      isEmailVerified: user.emailConfirmedAt != null,
    );
  }

  AppUser _requireUser(supabase.User? user) {
    final appUser = _toAppUser(user);
    if (appUser == null) {
      throw StateError('Supabase returned no user.');
    }
    return appUser;
  }

  Future<R> _run<R>(Future<R> Function() action) async {
    try {
      return await action();
    } catch (error) {
      throw mapAuthError(error);
    }
  }
}