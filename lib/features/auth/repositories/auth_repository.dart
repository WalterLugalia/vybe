import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthRepository {
  AuthRepository(this._service);

  final AuthService _service;

  AppUser? get currentUser => _service.currentUser;

  Stream<AppUser?> get userChanges => _service.userChanges;

  Future<AppUser> signUp({
    required String email,
    required String password,
    required String fullName,
    required String username,
  }) {
    return _service.signUp(
      email: email,
      password: password,
      fullName: fullName,
      username: username,
    );
  }

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) {
    return _service.signIn(email: email, password: password);
  }

  Future<void> signOut() => _service.signOut();
}