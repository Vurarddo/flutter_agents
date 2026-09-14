import 'package:flutter_agents/infrastructure/config/app_environment.dart';

abstract final class AppConfig {
  static const String appEnvRaw = String.fromEnvironment('APP_ENV', defaultValue: 'dev');
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://api-dev.example.com');
  static const String appName = String.fromEnvironment('APP_NAME', defaultValue: 'Flutter Agents Dev');

  static final AppEnvironment environment = AppEnvironment.fromString(appEnvRaw);

  static bool get isDev => environment == AppEnvironment.dev;
  static bool get isStage => environment == AppEnvironment.stage;
  static bool get isProd => environment == AppEnvironment.prod;
}
