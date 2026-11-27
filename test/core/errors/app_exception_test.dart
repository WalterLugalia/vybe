import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/errors/app_exception.dart';

void main() {
  test('NetworkException has a default user message and keeps its cause', () {
    final cause = Exception('socket closed');
    final error = NetworkException(cause: cause);

    expect(error.message, contains('internet'));
    expect(error.cause, same(cause));
  });

  test('ApiException carries a custom message and status code', () {
    const error = ApiException(message: 'Video not found', statusCode: 404);

    expect(error.message, 'Video not found');
    expect(error.statusCode, 404);
  });

  test('UnknownException has a default user message and no cause', () {
    const error = UnknownException();

    expect(error.message, contains('unexpected'));
    expect(error.cause, isNull);
  });

  test('toString includes the type and the message', () {
    const error = UnknownException(message: 'Boom');

    expect(error.toString(), 'UnknownException: Boom');
  });
}