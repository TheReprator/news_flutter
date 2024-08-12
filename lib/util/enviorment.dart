class Environment {
  const Environment._();

  static const String serverUrl = String.fromEnvironment('API_URL_NEWS');
  static const String apiKey = String.fromEnvironment('API_KEY_NEWS');
}
