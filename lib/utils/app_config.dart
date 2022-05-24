enum Environment { dev, prod }

extension EnvironmentExtensions on Environment {
  static Environment fromString(String string) {
    switch (string) {
      case "dev":
        return Environment.dev;
      case "prod":
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }

  String get value {
    switch (this) {
      case Environment.dev:
        return "dev";
      case Environment.prod:
        return "prod";
      default:
        return "dev";
    }
  }

  static String get key => "EnvironmentKey";
}

class AppConfig {
  static Map<String, dynamic> _config = {};

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.debugConstants;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static bool get isProduction {
    return env == Environment.prod;
  }

  static String get universitiesApiUrl {
    return _config[_Config.universitiesApiUrl];
  }

  static Environment get env {
    switch (_config[_Config.envKey]) {
      case "dev":
        return Environment.dev;
      case "prod":
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }
}

class _Config {
  static const String envKey = "ENV_KEY";
  static const String universitiesApiUrl = "UNIVERSITIES_API_URL";

  static Map<String, dynamic> debugConstants = {
    envKey: "dev",
    universitiesApiUrl: "http://universities.hipolabs.com",
  };

  static Map<String, dynamic> prodConstants = {
    envKey: "prod",
    universitiesApiUrl: "http://universities.hipolabs.com",
  };
}
