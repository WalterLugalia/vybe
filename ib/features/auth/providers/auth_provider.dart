import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/features/auth/providers/auth_state.dart';
import 'package:vybe/features/auth/repositories/auth_repository.dart';
import 'package:vybe/features/auth/services/auth_service.dart';


final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authServiceProvider));
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    final repository = ref.watch(authRepositoryProvider);

    final subscription = repository.userChanges.listen(
      (user) {
        state = AuthState(user: user, isBusy: state.isBusy);
      },
      onError: (Object error) {
        state = AuthState(
          user: state.user,
          error: UnknownException(cause: error),
        );
      },
    );
    ref.onDispose(subscription.cancel);

    return AuthState(user: repository.currentUser);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String username,
  }) {
    return _run(
      () => _repository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        username: username,
      ),
    );
  }

  Future<void> signIn({required String email, required String password}) {
    return _run(() => _repository.signIn(email: email, password: password));
  }

  Future<void> signOut() {
    return _run(_repository.signOut);
  }

  Future<void> _run(Future<void> Function() action) async {
    state = AuthState(user: state.user, isBusy: true);
    try {
      await action();
      state = AuthState(user: _repository.currentUser);
    } on AppException catch (error) {
      state = AuthState(user: state.user, error: error);
    }
  }
}