enum AppEnvironment {
  dev,
  stage,
  prod;

  static AppEnvironment fromString(String value) {
    return switch (value.toLowerCase()) {
      'dev' || 'development' => AppEnvironment.dev,
      'stage' || 'staging' => AppEnvironment.stage,
      'prod' || 'production' => AppEnvironment.prod,
      _ => AppEnvironment.dev,
    };
  }
}
