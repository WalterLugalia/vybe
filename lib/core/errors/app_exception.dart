sealed class AppException implements Exception {
  const AppException({required this.message, this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection. check your network and try again.',
    super.cause,
  });
} 

final class ApiException extends AppException {
  const ApiException({
    super.message = 'something went wrong. please try again later',
    super.cause,
    this.statusCode,
  
  });

  final int? statusCode;
}


final class UnknownException extends AppException{
  const UnknownException({
    super.message = 'something unexpected happend. please try again later',
    super.cause,
  });
}

final class StorageException extends AppException {
  const StorageException({
    super.message = 'something went wrong while accessing the storage.',
    super.cause,
  });
}
