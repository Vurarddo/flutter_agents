import 'dart:developer' as developer;

abstract final class AppLogger {
  static void log(String message, {String name = 'App', Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: name, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'ERROR', error: error, stackTrace: stackTrace, level: 1000);
  }
}
