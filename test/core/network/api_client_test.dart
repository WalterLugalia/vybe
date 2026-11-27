import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/errors/app_exception.dart';
import 'package:vybe/core/network/api_client.dart';

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ApiClient _clientWith(Future<ResponseBody> Function(RequestOptions) handler) {
  final dio = Dio()..httpClientAdapter = _FakeAdapter(handler);
  return ApiClient(dio: dio);
}

ResponseBody _jsonBody(String json, {int status = 200}) {
  return ResponseBody.fromString(
    json,
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

void main() {
  test('getJson returns the decoded JSON object and sends query values',
      () async {
    late RequestOptions seen;
    final client = _clientWith((options) async {
      seen = options;
      return _jsonBody('{"ok":true}');
    });

    final result = await client.getJson('/test', queryParameters: {'page': 2});

    expect(result, {'ok': true});
    expect(seen.queryParameters, {'page': 2});
  });

  test('postJson sends the body', () async {
    late RequestOptions seen;
    final client = _clientWith((options) async {
      seen = options;
      return _jsonBody('{"created":true}');
    });

    final result = await client.postJson('/test', data: {'name': 'vybe'});

    expect(result, {'created': true});
    expect(seen.data, {'name': 'vybe'});
  });

  test('a reply that is not a JSON object becomes an ApiException', () async {
    final client = _clientWith((options) async => _jsonBody('[1,2,3]'));

    await expectLater(
      client.getJson('/test'),
      throwsA(isA<ApiException>()),
    );
  });

  test('a server error becomes an ApiException with its status code',
      () async {
    final client = _clientWith((options) async => _jsonBody('{}', status: 500));

    await expectLater(
      client.getJson('/test'),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 500)
            .having((e) => e.cause, 'cause', isA<DioException>()),
      ),
    );
  });

  test('a connection failure becomes a NetworkException', () async {
    final client = _clientWith((options) async {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
      );
    });

    await expectLater(
      client.getJson('/test'),
      throwsA(isA<NetworkException>()),
    );
  });

  test('a timeout becomes a NetworkException', () async {
    final client = _clientWith((options) async {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.receiveTimeout,
      );
    });

    await expectLater(
      client.getJson('/test'),
      throwsA(isA<NetworkException>()),
    );
  });
}