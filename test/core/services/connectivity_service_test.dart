import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/services/connectivity_service.dart';

class _FakeConnectivity implements Connectivity {
  _FakeConnectivity(this.current);

  List<ConnectivityResult> current;
  final StreamController<List<ConnectivityResult>> controller =
      StreamController<List<ConnectivityResult>>();

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => current;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      controller.stream;
}

void main() {
  test('is online when at least one connection type is available', () async {
    final fake = _FakeConnectivity([
      ConnectivityResult.none,
      ConnectivityResult.mobile,
    ]);

    expect(await ConnectivityService(connectivity: fake).isOnline(), isTrue);
  });

  test('is offline when the only result is none', () async {
    final fake = _FakeConnectivity([ConnectivityResult.none]);

    expect(await ConnectivityService(connectivity: fake).isOnline(), isFalse);
  });

  test('is offline when the result list is empty', () async {
    final fake = _FakeConnectivity([]);

    expect(await ConnectivityService(connectivity: fake).isOnline(), isFalse);
  });

  test('onlineChanges reports only real changes, including a reconnect',
      () async {
    final fake = _FakeConnectivity([ConnectivityResult.wifi]);
    final service = ConnectivityService(connectivity: fake);

    final expectation = expectLater(
      service.onlineChanges,
      emitsInOrder([true, false, true, emitsDone]),
    );

    fake.controller.add([ConnectivityResult.wifi]);
    fake.controller.add([ConnectivityResult.wifi, ConnectivityResult.mobile]);
    fake.controller.add([ConnectivityResult.none]);
    fake.controller.add([ConnectivityResult.wifi]);
    await fake.controller.close();

    await expectation;
  });
}