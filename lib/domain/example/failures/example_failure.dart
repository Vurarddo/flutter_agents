sealed class ExampleFailure {
  final String message;

  const ExampleFailure([this.message = 'An unexpected error occurred.']);
}

final class NetworkExampleFailure extends ExampleFailure {
  const NetworkExampleFailure([
    super.message = 'No internet connection or network request timed out.',
  ]);
}

final class ServerExampleFailure extends ExampleFailure {
  final int? statusCode;

  const ServerExampleFailure({
    String message = 'A server error occurred while processing the request.',
    this.statusCode,
  }) : super(message);
}

final class UnknownExampleFailure extends ExampleFailure {
  final Object? error;
  final StackTrace? stackTrace;

  const UnknownExampleFailure({
    String message = 'An unexpected error occurred.',
    this.error,
    this.stackTrace,
  }) : super(message);
}
