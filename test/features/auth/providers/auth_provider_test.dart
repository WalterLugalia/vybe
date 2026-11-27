import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/features/auth/models/app_user.dart';

import 'package:vybe/features/auth/repositories/auth_repository.dart';

import 'package:vybe/features/auth/providers/auth_provider.dart';

const _user = AppUser(
  id: 'user-1',
  email: 'maya@example.com',
  isEmailVerified: true,
);

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({this.user});

  AppUser? user;
  Object? failure;
  Completer<void>? gate;
  final StreamController<AppUser?> controller =
      StreamController<AppUser?>.broadcast();

  @override
  AppUser? get currentUser => user;

  @override
  Stream<AppUser?> get userChanges => controller.stream;

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    required String fullName,
    required String username,
  }) {
    return signIn(email: email, password: password);
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    await gate?.future;
    final error = failure;
    if (error != null) {
      throw error;
    }
    user = _user;
    return _user;
  }

  @override
  Future<void> signOut() async {
    user = null;
  }
}

ProviderContainer _containerFor(_FakeAuthRepository fake) {
  final container = ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(fake)],
  );
  addTearDown(container.dispose);
  addTearDown(fake.controller.close);
  return container;
}

void main() {
  test('starts signed out when there is no saved user', () {
    final container = _containerFor(_FakeAuthRepository());

    final state = container.read(authProvider);

    expect(state.isAuthenticated, isFalse);
    expect(state.isBusy, isFalse);
    expect(state.error, isNull);
  });

  test('starts signed in when a session was restored', () {
    final container = _containerFor(_FakeAuthRepository(user: _user));

    expect(container.read(authProvider).user, same(_user));
  });

  test('signing in makes the user authenticated', () async {
    final container = _containerFor(_FakeAuthRepository());

    await container
        .read(authProvider.notifier)
        .signIn(email: 'maya@example.com', password: 'password123');

    final state = container.read(authProvider);
    expect(state.isAuthenticated, isTrue);
    expect(state.isBusy, isFalse);
    expect(state.error, isNull);
  });

  test('the state is busy while an action is running', () async {
    final fake = _FakeAuthRepository()..gate = Completer<void>();
    final container = _containerFor(fake);

    final pending = container
        .read(authProvider.notifier)
        .signIn(email: 'maya@example.com', password: 'password123');

    expect(container.read(authProvider).isBusy, isTrue);

    fake.gate!.complete();
    await pending;

    expect(container.read(authProvider).isBusy, isFalse);
  });

  test('a failed sign in keeps the user signed out and stores the error',
      () async {
    final fake = _FakeAuthRepository()
      ..failure = const AuthException(
        failure: AuthFailure.invalidCredentials,
        message: 'Incorrect email or password.',
      );
    final container = _containerFor(fake);

    await container
        .read(authProvider.notifier)
        .signIn(email: 'maya@example.com', password: 'wrong');

    final state = container.read(authProvider);
    expect(state.isAuthenticated, isFalse);
    expect(state.isBusy, isFalse);
    expect(
      state.error,
      isA<AuthException>().having(
        (e) => e.failure,
        'failure',
        AuthFailure.invalidCredentials,
      ),
    );
  });

  test('signing out makes the user unauthenticated', () async {
    final container = _containerFor(_FakeAuthRepository(user: _user));
    container.read(authProvider);

    await container.read(authProvider.notifier).signOut();

    expect(container.read(authProvider).isAuthenticated, isFalse);
  });

  test('a user change from the stream updates the state', () async {
    final fake = _FakeAuthRepository();
    final container = _containerFor(fake);
    container.read(authProvider);

    fake.controller.add(_user);
    await pumpEventQueue();

    expect(container.read(authProvider).user, same(_user));
  });

  test('a stream error is stored as an UnknownException', () async {
    final fake = _FakeAuthRepository();
    final container = _containerFor(fake);
    container.read(authProvider);

    fake.controller.addError(StateError('stream broke'));
    await pumpEventQueue();

    expect(container.read(authProvider).error, isA<UnknownException>());
  });


   test('clearError removes a stored error', () async {
    final fake = _FakeAuthRepository()
      ..failure = const AuthException(
        failure: AuthFailure.invalidCredentials,
        message: 'Incorrect email or password.',
      );
    final container = _containerFor(fake);

    await container
        .read(authProvider.notifier)
        .signIn(email: 'maya@example.com', password: 'wrong');
    expect(container.read(authProvider).error, isNotNull);

    container.read(authProvider.notifier).clearError();

    final state = container.read(authProvider);
    expect(state.error, isNull);
    expect(state.isBusy, isFalse);
  });

  test('clearError does nothing when there is no error', () {
    final container = _containerFor(_FakeAuthRepository());
    final before = container.read(authProvider);

    container.read(authProvider.notifier).clearError();

    expect(container.read(authProvider), same(before));
  }); 


    test('a sign-out event from the stream clears the user', () async {
    final fake = _FakeAuthRepository(user: _user);
    final container = _containerFor(fake);
    container.read(authProvider);
    expect(container.read(authProvider).user, same(_user));

    fake.controller.add(null);
    await pumpEventQueue();

    expect(container.read(authProvider).isAuthenticated, isFalse);
  });


}